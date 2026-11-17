# Evaluation: iteration-009-lead-developer-ownership-loop

## Objective

Address cases where `lead` delegated implementation to `developer`, reviewed the
result, and then made follow-up code edits itself.

## Evidence

- `manual_oracle`: this happened during generic free-form development requests,
  outside explicit slash commands.
- `static_contract`: lead's role is routing and coordination.

## Result

Make the implementation ownership loop explicit: once `developer` owns a task,
follow-up implementation corrections for the same request go back to
`developer`.
