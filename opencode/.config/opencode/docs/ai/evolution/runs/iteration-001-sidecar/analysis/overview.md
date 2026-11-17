# Analysis: iteration-001-sidecar

The confirmed issue was local to `/feature` wording, not to the sidecar model.

Root cause:

- Global harness docs had the intended base feature flow.
- The `/feature` command did not state the same exact sequence locally.
- Sidecar agents were not being made mandatory by the inspected contracts.

Recommended fix: keep any future change scoped to `commands/feature.md` unless
new evidence shows a broader orchestration problem.
