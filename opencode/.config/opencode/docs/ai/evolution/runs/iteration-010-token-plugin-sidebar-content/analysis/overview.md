# Analysis: iteration-010-token-plugin-sidebar-content

The plugin sums assistant message token usage for the current session and each
child session reachable through `session.children`. It renders:

- lead/root token usage;
- total token usage including child sessions;
- child-session count;
- partial-total state when a child session cannot be read.

For the public kit the registration must be relative and portable, with no
absolute local paths.
