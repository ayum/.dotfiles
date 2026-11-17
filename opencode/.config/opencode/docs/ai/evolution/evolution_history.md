# Evolution History

## Iteration 000 - Baseline

Baseline harness before formal AHE records.

Observable components:

- `agents/`
- `commands/`
- `skills/open-design/`
- `tools/open_design.ts`
- `docs/ai/harness/`

Notes:

- Real rollback requires git.
- The first local evolution should create `docs/ai/evolution/runs/iteration-001/`
  with evaluation, analysis, manifest, and change evaluation.

## Iteration 003 - Agent Readable Harness

Status: `keep`.

Changes:

- `AGENTS.md` acts as a short harness index.
- `docs/ai/harness/` is the source of truth for agent, command, evidence, and
  check contracts.
- `scripts/check-harness.mjs` validates local invariants without new
  dependencies.
- `docs/ai/evolution/benchmarks/manual-scenarios.md` documents replay through
  `opencode run --format json --thinking` and the evidence taxonomy.

Evidence:

- `node scripts/check-harness.mjs` passed.
- A real `transcript_replay` confirmed that a small free-form request routes to
  `developer`.

## Iteration 004 - Orchestration Audit

Status: `keep` for approved scope; remaining proposals deferred.

Applied changes:

- `chg-1-ahe-run-lifecycle-validator`: the local validator allows an
  evaluator-only AHE intermediate run while keeping strict checks once a
  manifest exists.
- `chg-2-evolve-evaluation-only-contract`: `/evolve` now distinguishes the full
  AHE flow from evaluation-only, debugger-only, no-apply, and no-manifest
  branches.

Deferred changes:

- `chg-3-slash-command-contract-coverage`.
- `chg-4-design-open-design-baseurl-contract`.

Evidence:

- `node scripts/check-harness.mjs` passed.
- Temporary positive and negative lifecycle fixtures passed/fail as expected.
- `change_evaluation.json` records `keep` for the approved scope and documents
  the remaining transcript replay limitation for `/evolve`.

## Iteration 013 - Doc Gardening Mechanical Checks

Status: `keep`.

Changes:

- `scripts/check-harness.mjs` validates that `AGENTS.md` stays a short index.
- The checker requires documentation coverage for visible agents and commands.
- The checker validates local paths referenced by manifests and evaluations.
- `docs/ai/harness/checks.md` documents these rules as mechanical doc gardening.

Evidence:

- `node --check scripts/check-harness.mjs` passed.
- `node scripts/check-harness.mjs` passed.
- A temporary negative control confirmed the expected failure when a command is
  not documented.
- `./scripts/check.sh` passed from the public repository root.
