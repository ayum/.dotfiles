# Analysis: iteration-009-lead-developer-ownership-loop

The root cause was missing loop ownership language. The fix:

- denies file editing to `lead`;
- states that `lead` may inspect, synthesize, decide, and delegate;
- routes implementation corrections back to `developer`;
- mirrors the invariant in agent-readable harness docs;
- adds mechanical checks to preserve the contract.
