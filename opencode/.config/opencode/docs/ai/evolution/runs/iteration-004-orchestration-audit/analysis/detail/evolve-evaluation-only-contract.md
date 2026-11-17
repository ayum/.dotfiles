# Detail: evolve evaluation-only contract

Problem:

`/evolve` needed to support audit/evaluation requests that intentionally stop
after evaluator or debugger output.

Fix direction:

- document `evaluation-only`;
- document `debugger-only` / `no-apply` branches;
- keep manifest and developer work conditional on evidence, user scope, and
  approval.

The change must not imply rollback without git.
