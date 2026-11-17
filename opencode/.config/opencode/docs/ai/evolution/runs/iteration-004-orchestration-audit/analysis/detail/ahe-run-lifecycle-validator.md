# Pattern: AHE run lifecycle validator rejects valid intermediate state

## Observed evidence

- `evaluation.md` S1 records `node scripts/check-harness.mjs` passing before the evaluator artifact existed and failing after `evaluation.md` was created.
- Failure text: `docs/ai/evolution/runs/iteration-004-orchestration-audit: missing analysis/overview.md`.
- `scripts/check-harness.mjs:153-159` iterates every run directory and always requires both `evaluation.md` and `analysis/overview.md`.
- `agents/evaluator.md:63-69` says evaluator creates `evaluation.md` and leaves `analysis/` for debugger.
- `agents/debugger.md:33` says debugger produces `analysis/overview.md` for AHE.

## Expected behavior

The local harness check should distinguish a valid AHE run in progress from an invalid completed run. A state with `evaluation.md` but no `analysis/overview.md` is valid between evaluator and debugger, especially when the current task is step 2 to create analysis.

## Root cause

The validator models AHE runs as an all-or-nothing final shape. It has no lifecycle/stage rule and therefore treats a legitimate evaluator-only intermediate state as structurally broken.

## Affected component level

`tool` primarily (`scripts/check-harness.mjs`), with `workflow` implications for AHE validation timing.

## Candidate remediation

- Teach the check an explicit AHE lifecycle: e.g. `evaluation.md` alone is allowed for an in-progress evaluator stage; `analysis/overview.md` is required before manifest or closure; manifests still require shape validation and follow-up evaluation rules.
- Keep safeguards for abandoned/incoherent runs, such as flagging manifest without analysis or invalid JSON.
- Document the accepted intermediate states in `docs/ai/harness/checks.md`.

## Confidence

High. The failing line is explicit in the script, and the agent contracts explicitly assign `analysis/` to debugger.

## Evidence that would falsify it

- A harness policy stating `check-harness` must only be run after debugger and never during evaluator phase.
- A hidden convention requiring evaluator to create a placeholder `analysis/overview.md` before handoff. No such convention was found in inspected docs.

## Evidence sufficiency for evolver

Sufficient for a manifest proposing a validator/tool change. Post-change validation should include running `node scripts/check-harness.mjs` in both an evaluator-only run state and a complete run state.
