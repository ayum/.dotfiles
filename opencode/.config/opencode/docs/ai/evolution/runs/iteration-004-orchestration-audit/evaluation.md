# Evaluation: iteration-004-orchestration-audit

## Objective

Audit the harness after the agent-readable documentation change and identify
contract drift that could block future AHE runs.

## Evidence

- `static_contract`: harness docs, slash commands, AHE run files, and Open
  Design command/skill contracts.
- local validator: `node scripts/check-harness.mjs`.

## Findings

- AHE lifecycle validation was too strict for in-progress evaluator/debugger
  states.
- `/evolve` needed explicit evaluation-only and debugger-only branches.
- Command coverage had gaps for visible auxiliary commands.
- Open Design instructions had drifted from the exposed tool contract.

## Result

The first two fixes were applied in this iteration. Later iterations handled the
remaining command coverage and Open Design contract details.
