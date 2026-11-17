# Evaluation: iteration-001-sidecar

## Objective

Validate that `evaluator`, `debugger`, and `evolver` remain optional sidecars
and do not become mandatory phases for normal feature work.

## Evidence

- `static_contract`: `commands/feature.md`, `commands/scope.md`,
  `commands/evolve.md`, `agents/lead.md`, and sidecar agent prompts.

## Result

The sidecar agents were correctly scoped as optional. The evaluation found a
separate `/feature` wording ambiguity: the command did not expose the exact base
flow string used by the global docs.

No behavior change was applied in this evaluator pass.
