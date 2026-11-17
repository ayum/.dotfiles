# Evaluation: iteration-010-token-plugin-sidebar-content

## Objective

Expose token usage for the lead session and total usage across child/subagent
sessions in the OpenCode TUI.

## Evidence

- `manual_oracle`: OpenCode's built-in sidebar showed context for the lead/root
  session only, not total subagent token usage.
- `static_contract`: the plugin could query session messages and children via
  the TUI plugin API.

## Result

Add a portable TUI plugin and register it in `tui.json`.
