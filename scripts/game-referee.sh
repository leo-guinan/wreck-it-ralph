#!/usr/bin/env bash
set -euo pipefail

echo "🧑‍⚖️ Gamepack Referee"

require_file() {
  [[ -f "$1" ]] || { echo "Missing required file: $1"; exit 1; }
}

require_file gamepack/VISION.md
require_file gamepack/GAME.md
require_file gamepack/RULES.md
require_file gamepack/REFEREE.md
require_file gamepack/SCORING.md
require_file gamepack/ROLES.md
require_file gamepack/MEMORY.md
require_file gamepack/PLAYTEST.md
require_file gamepack/QUESTS.json
require_file gamepack/prompt.md
require_file gamepack/turn_prompt.md

# Light sanity checks
grep -q "Win condition" gamepack/GAME.md || { echo "GAME.md must include 'Win condition'"; exit 1; }
grep -q "Bank" gamepack/REFEREE.md || { echo "REFEREE.md must define banking rules"; exit 1; }

# QUESTS.json must be valid JSON
jq -e . gamepack/QUESTS.json >/dev/null

# No contradictory “one quest per turn” violations
grep -qi "one quest per turn" gamepack/RULES.md || {
  echo "RULES.md must explicitly say one quest per turn"
  exit 1
}

echo "✅ Gamepack Referee passed"
