# Evolution Runs

Each AHE iteration should create an `iteration-XXX-*` directory.

Expected files:

- `evaluation.md`: evaluator evidence and scenario results.
- `analysis/overview.md`: debugger synthesis and root causes.
- `analysis/detail/*.md`: optional deeper evidence per pattern or scenario.
- `change_manifest.json`: proposed or applied changes for the iteration.
- `change_evaluation.json`: attribution of the previous change against later
  results.

Evaluation-only runs may contain only `evaluation.md` while work is in progress.
When a manifest exists, the run also needs analysis and change evaluation.
