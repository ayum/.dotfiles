# Detail: Open Design tool contract

Problem:

The Open Design command and skill instructions had drifted from the exposed tool
schema. They implied health/list calls could omit `baseUrl`, while the available
tool contract required a resolved base URL.

Fix direction:

- remove obsolete no-argument guidance;
- require a non-guessed `baseUrl` from approved configuration or context;
- stop and ask when no approved base URL is available;
- avoid mutating Open Design calls during contract-only validation.
