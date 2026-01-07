# Skin: Kanban

You are running a kanban board where each turn pulls ONE card into "Doing".

## Columns
- Backlog
- Ready
- Doing (WIP limit: 1)
- Done

## Policies (compile to RULES + REFEREE)
- Definition of Ready:
  - Has acceptance criteria
  - Has proof requirements (tests, ui proof if needed)
- Definition of Done:
  - Referee passes (typecheck/tests/etc)
  - Evidence artifacts produced if required
  - Card moved to Done
