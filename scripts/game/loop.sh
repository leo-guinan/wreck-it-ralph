#!/usr/bin/env bash
set -euo pipefail

MAX_TURNS="${1:-10}"
SLEEP_SECS="${SLEEP_SECS:-2}"

echo "🎮 Starting Game Loop (max turns: $MAX_TURNS)"

for i in $(seq 1 "$MAX_TURNS"); do
  echo "════════════════════════════════════"
  echo "Turn $i"
  echo "════════════════════════════════════"

  if ./scripts/game/turn.sh; then
    echo "✅ Turn completed"
  else
    echo "❌ Turn failed (referee rejected or agent failed). Stopping."
    exit 1
  fi

  if jq -e '.quests | all(.passes == true)' game/QUESTS.json > /dev/null; then
    echo "🏁 GAME COMPLETE — all quests pass."
    exit 0
  fi

  sleep "$SLEEP_SECS"
done

echo "⚠️ Max turns reached without completing all quests."
exit 1
