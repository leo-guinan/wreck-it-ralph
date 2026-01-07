#!/usr/bin/env bash
set -euo pipefail

require() { command -v "$1" >/dev/null 2>&1 || { echo "Missing dependency: $1"; exit 2; }; }
require jq
require git

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

# Configure your agent command here (Amp / Claude Code / etc.)
AGENT_CMD="${AGENT_CMD:-amp --dangerously-allow-all}"

# Find the next quest (lowest priority number, not yet passing)
NEXT_ID="$(
  jq -r '
    .quests
    | map(select(.passes == false))
    | sort_by(.priority)
    | .[0].id // empty
  ' game/QUESTS.json
)"

if [[ -z "$NEXT_ID" ]]; then
  echo "No remaining quests. Nothing to do."
  exit 0
fi

TITLE="$(jq -r --arg id "$NEXT_ID" '.quests[] | select(.id==$id) | .title' game/QUESTS.json)"
echo "🎯 Next quest: $NEXT_ID — $TITLE"

# Safety: ensure clean start
if ! git diff --quiet; then
  echo "Working tree not clean. Commit/stash before running the game."
  exit 3
fi

# Ensure notes file exists empty (agent writes to it)
: > game/turn_notes.md

# Run the agent for ONE turn
# Prompt instructs agent to implement quest ONLY and write game/turn_notes.md
cat game/prompt.md \
  | sed "s/{{QUEST_ID}}/$NEXT_ID/g" \
  | sed "s/{{QUEST_TITLE}}/$TITLE/g" \
  | bash -lc "$AGENT_CMD"

# Referee decides if we can bank the turn
./scripts/game/referee.sh

# If referee passes, commit + mark quest done + append memory
# Append notes if present
DATE_STR="$(date +%Y-%m-%d)"
{
  echo ""
  echo "## $DATE_STR — $NEXT_ID — $TITLE"
  echo ""
  if [[ -s game/turn_notes.md ]]; then
    cat game/turn_notes.md
  else
    echo "- (No notes provided)"
  fi
  echo ""
  echo "---"
} >> game/MEMORY.md

# Commit changes
git add -A
git commit -m "feat(game): $NEXT_ID - $TITLE"

# Mark quest as passing
tmpfile="$(mktemp)"
jq --arg id "$NEXT_ID" '
  .quests = (.quests | map(if .id == $id then .passes = true else . end))
' game/QUESTS.json > "$tmpfile"
mv "$tmpfile" game/QUESTS.json

echo "🏦 Banked quest $NEXT_ID"
exit 0
