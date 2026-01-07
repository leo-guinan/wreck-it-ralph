🎮 The Game of Programming

Ralph-style control loops, turned into games you can actually play

What This Repo Is

This repository implements a game-based orchestration layer for AI-assisted programming, built on top of the Ralph Wiggum Technique.

Ralph provides the motor: a dumb, persistent loop that applies a desired state repeatedly.

The Game of Programming provides the rules, referee, scoring, and rituals that prevent missed observations and vibe-only coding.

Together, they let you design the game you want to play, while keeping rigor, convergence, and human judgment at the edges.

This is not an “autonomous agent.”
It is a turn-based system where:

the game decides the rules,

the loop executes one move at a time,

and only verified progress gets banked.

The Ralph Wiggum Technique (Baseline)

Ralph is a minimal control loop popularized by Geoff Huntley.

At its core:

while :; do
  cat PROMPT.md | <ai-agent>
done

What Ralph Actually Is

A stateless projection loop

Each iteration is a fresh context window

Memory lives only in:

the codebase itself

git commits

visible text files

Ralph works because:

It avoids long-horizon planning

It forces repeated reconciliation with reality

It turns specs into attractors instead of instructions

What Ralph Is Not

Not autonomous

Not goal-setting

Not self-directing

Not safe to “run forever”

Ralph is powerful precisely because it is dumb, killable, and externally controlled.

Why We Added a Game Layer

Raw Ralph loops fail in predictable ways:

Missed observations (files not read, checks not run)

Scope creep (“while I’m here…”)

Overbaking (inventing features after constraints are satisfied)

Fragile mental models (“agent magic” thinking)

The solution is not smarter agents.

The solution is:

Explicit rules, referees, evidence, and turn structure.

That’s what the Game of Programming provides.

The Core Idea: Two Loops
1. Ralph Loop (Change Engine)

Executes one bounded change

Applies a declarative desired state

Writes changes to the repo

Stops or repeats

2. Game Loop (Referee + Scoreboard)

Defines what a “turn” is

Decides what counts as a valid move

Requires proof (tests, screenshots, checks)

Controls when progress is banked

Ralph never chooses the game.
The game chooses Ralph’s next move.

Turn-Based Programming

Every iteration is a turn.

A turn always follows the same phases:

Observe – inspect the current repo state

Choose – select exactly one quest

Act – implement the smallest viable change

Verify – run required checks / produce evidence

Log – record learnings and patterns

Bank – commit only if the referee passes

If any phase fails, the turn does not count.

Quests, Not Tasks

Work is expressed as quests with explicit acceptance criteria.

Good quests:

Small

Independent

Testable in one context window

Bad quests:

“Build the whole system”

“Refactor everything”

“Prepare for future work”

The system enforces one quest per turn.

Referees (The Anti–Vibe-Coding Layer)

A referee is a set of required proofs before progress can be banked.

Examples:

npm run typecheck

npm test

lint

UI screenshot evidence

diff-size limits

If the referee fails:

no commit

no quest completion

no score

This eliminates “it looks good to me” failure modes.

Memory Model (Deliberately Limited)

There is no hidden memory.

Memory persists only through:

git history

visible markdown / json files

accumulated patterns in MEMORY.md or AGENTS.md

This keeps the system:

debuggable

restartable

resistant to drift

Designing Your Own Game

This repo includes a Game Designer Loop that lets you create custom games.

Instead of looping over features, it loops over requirements for the game itself:

turn structure

rules

referee gates

scoring

memory model

starter quests

You describe your intent in plain language, and the designer produces a runnable Game Pack.

Skins: Keep Your Mental Model

Different people think in different metaphors.
The system supports multiple skins that all compile to the same core engine:

🧱 Kanban

Cards move from Ready → Done

WIP limits enforced

Definition of Ready / Done maps to referee rules

🐉 RPG Dungeon

Rooms = quests

Monsters = referee checks

Loot = reusable patterns and bonuses

🏟️ Sports Season

Matches = turns

Playbook = coding standards

Replay review = tests and verification

Skins are presentation only.
Under the hood, they all produce the same normalized game format.

What This Repo Is Good For

✅ Great for:

Small, safe feature shipping

Incremental refactors

Bug fixing

Learning a new codebase

Teaching agentic workflows without mysticism

🚫 Not for:

Exploratory product ideation

Vague goals

Security-critical changes without human review

“Set it and forget it” autonomy

Why This Works

This system works because it aligns incentives:

Agents optimize for passing referees

Humans define the game

Progress is observable and reversible

Failure modes are explicit

If a dumb loop plus a good game can outperform “smart agents,”
the bottleneck isn’t intelligence — it’s specification and judgment.

Getting Started (High Level)

Pick a starter game (Kanban / RPG / Sports)

Edit the quest board and rules

Run the game loop

Review turns like game replays

Adjust the game, not the agent

Philosophy (TL;DR)

Dumb loops beat clever agents

Rules beat vibes

Evidence beats intention

Games beat abstractions

Humans stay in control

Welcome to the Game of Programming.
