# Evaluation: iteration-007-agent-skills-integration

## Objective

Evaluate whether the local harness should integrate process skills inspired by
agent-skills without turning every task into a heavier flow.

## Evidence

- `static_contract`: existing agents, commands, and skill directory shape.
- `manual_oracle`: local usage needed checklists for testing, source-driven
  development, review, security, performance, simplification, and ADRs.

## Result

The integration should be agent-level skill allowlists plus optional checklist
language, not a new mandatory orchestration layer.
