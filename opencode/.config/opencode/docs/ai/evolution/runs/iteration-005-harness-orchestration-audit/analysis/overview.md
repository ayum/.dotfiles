# Analysis: iteration-005-harness-orchestration-audit

The root causes were source-of-truth drift in command documentation and drift
between Open Design instructions and the exposed tool schema.

The chosen fix stayed local to command/skill contracts:

- classify `/research` and `/implement` as visible auxiliary/subtask commands;
- keep sidecars out of normal app-feature flows;
- require Open Design `baseUrl` to come from approved configuration/context;
- avoid hardcoded local URLs, providers, credentials, or model settings.

The analysis did not justify changes to model/provider configuration.
