# Analysis: iteration-008-lead-readonly-shell-permissions

The root cause was an allowlist gap, not an orchestration bug. The fix adds
specific read-only commands for lightweight repository inspection:

- `ls*`
- `find *`
- `grep *`
- `rg *`
- `tail *`
- `wc *`

The fallback remains `bash "*": ask`.
