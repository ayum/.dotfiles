# Analysis: iteration-004-orchestration-audit

Root causes:

- The harness validator treated some legitimate AHE in-progress states as
  invalid.
- `/evolve` implied manifest creation too strongly for evaluation-only or
  debugger-only requests.
- Some visible commands and Open Design contracts had documentation drift.

Applied scope:

- relax lifecycle validation only for documented in-progress states;
- clarify `/evolve` non-apply branches;
- defer command coverage and Open Design fixes to later iterations.

This was a harness-contract change only.
