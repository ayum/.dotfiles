# Evaluation: iteration-011-lead-cd-which-permissions

## Objective

Allow `lead` to run routine `cd` and `which` commands without repeated approval
prompts.

## Evidence

- `manual_oracle`: a fresh OpenCode TUI session still prompted for these simple
  navigation and command-discovery commands.
- `static_contract`: `lead` already had a narrow read-only shell allowlist with
  `bash "*": ask` as fallback.

## Result

Add exact and argumented allowlist entries for `cd` and `which`.
