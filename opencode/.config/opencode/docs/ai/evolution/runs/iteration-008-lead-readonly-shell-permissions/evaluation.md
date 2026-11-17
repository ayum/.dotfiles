# Evaluation: iteration-008-lead-readonly-shell-permissions

## Objective

Reduce approval prompts for harmless read-only shell inspection by `lead`.

## Evidence

- `manual_oracle`: repeated prompts for `ls`, `grep`, `tail`, `find`, and `wc`
  slowed normal routing inspection.
- `static_contract`: `lead` still had `bash "*": ask`, so additions could stay
  narrow.

## Result

Allow only common read-only inspection commands while keeping all other bash
commands gated by approval.
