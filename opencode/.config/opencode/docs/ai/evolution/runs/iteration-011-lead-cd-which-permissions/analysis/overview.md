# Analysis: iteration-011-lead-cd-which-permissions

This is an allowlist gap. The fix is intentionally narrow:

- allow `cd`;
- allow `cd *`;
- allow `which`;
- allow `which *`;
- keep `bash "*": ask`;
- keep `edit: deny` for `lead`.
