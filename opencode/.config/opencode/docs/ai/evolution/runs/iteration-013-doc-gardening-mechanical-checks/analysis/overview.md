# Iteration 013 Analysis

## Evidence reviewed

- `scripts/check-harness.mjs`
- `docs/ai/harness/checks.md`
- `docs/ai/evolution/runs/iteration-013-doc-gardening-mechanical-checks/evaluation.md`

## Root cause

The harness already documented doc gardening as a practice, but several cheap
rules were still manual: keeping `AGENTS.md` short, documenting all visible
agents and commands, and avoiding broken local evidence paths in AHE JSON.

## Chosen component

The narrowest fix is tooling plus docs:

- `scripts/check-harness.mjs` enforces the rules locally.
- `docs/ai/harness/checks.md` declares the rules as mechanical doc gardening.

No agent contract, command flow, provider, model, or permission change is needed.

## Attribution expectation

Future harness edits should fail earlier when they add agents, commands, or AHE
evidence without updating the local knowledge map.
