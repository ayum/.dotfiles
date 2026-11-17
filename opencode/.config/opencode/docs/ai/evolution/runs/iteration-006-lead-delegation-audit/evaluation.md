# Evaluation: iteration-006-lead-delegation-audit

## Objective

Investigate reports that `/feature` allowed `lead` to perform too much direct
technical discovery before delegating uncertainty to `researcher`.

## Evidence

- `static_contract`: `commands/feature.md`, `agents/lead.md`, and
  `docs/ai/harness/commands.md`.
- `transcript_replay`: prior local replay evidence showed `lead` could delegate
  to `researcher`, but `/feature` intake wording encouraged broad direct
  inspection first.

## Result

The issue was traced to command wording, not to provider, model, or MCP setup.
