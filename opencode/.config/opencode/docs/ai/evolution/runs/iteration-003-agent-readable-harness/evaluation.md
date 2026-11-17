# Evaluation: iteration-003-agent-readable-harness

## Objective

Make the harness easier for agents to inspect by moving stable contracts out of
the short `AGENTS.md` file and into versioned docs under `docs/ai/harness/`.

## Evidence

- `static_contract`: short global map plus dedicated agent, command, evidence,
  and check docs.
- local validator: `node scripts/check-harness.mjs`.
- transcript replay: one small free-form request confirmed the intended direct
  routing contract at the time.

## Result

The harness docs became agent-readable and the validator caught real formatting
issues during development. The change did not modify models, providers, or
credentials.
