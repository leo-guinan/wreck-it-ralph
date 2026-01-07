#!/usr/bin/env bash
set -euo pipefail

MAX_TURNS="${1:-12}"
SLEEP_SECS="${SLEEP_SECS:-1}"

AGENT_CMD="${AGENT_CMD:-amp --dangerously-allow-all}"

echo "🧩 Starting Game Designer Loop (max turns: $MAX_TURNS)"

for i in $(seq 1 "$MAX_TURNS"); do
  echo "════════════════════════════════════"
  echo "Design Turn $i"
  echo "════════════════════════════════════"

  # run one design iteration
  OUTPUT="$(
    cat gamepack/prompt.md | bash -lc "$AGENT_CMD" 2>&1 | tee /dev/stderr
  )" || true

  # run referee over the gamepack requirements
  if ./scripts/game_referee.sh; then
    echo "✅ Gamepack passes referee"

    # Optional: stop if the designer explicitly declares it complete
    if echo "$OUTPUT" | grep -q "<promise>GAME_COMPLETE</promise>"; then
      echo "🏁 Designer declared complete."
      exit 0
    fi

    # If referee passes and all REQs are marked done, stop
    if jq -e '.requirements | all(.passes == true)' gamepack/QUESTS.json >/dev/null; then
      echo "🏁 All game requirements complete."
      exit 0
    fi
  else
    echo "❌ Gamepack failed referee — continuing."
  fi

  sleep "$SLEEP_SECS"
done

echo "⚠️ Max design turns reached."
exit 1
