# Iteration 013 - Doc Gardening Mechanical Checks

## Objective evaluated

Convert cheap doc-gardening rules into local mechanical checks without changing
agent routing, permissions, models, providers, or workflow behavior.

## Scenarios executed

### Scenario 1 - Script syntax

- Evidence type: `static_contract`
- Command:

```bash
node --check scripts/check-harness.mjs
```

- Expected: syntax check exits successfully.
- Result: pass.

### Scenario 2 - Harness contract check

- Evidence type: `static_contract`
- Command:

```bash
node scripts/check-harness.mjs
```

- Expected: checker accepts the packaged harness and reports
  `Harness check passed.`
- Result: pass.

### Scenario 3 - Negative doc coverage control

- Evidence type: `static_contract`
- Command:

```bash
tmpdir="$(mktemp -d)"
cp -R . "$tmpdir/opencode"
python3 - "$tmpdir/opencode/docs/ai/harness/commands.md" <<'PY'
from pathlib import Path
path = Path(__import__("sys").argv[1])
text = path.read_text()
path.write_text(text.replace("### `/test`", "### `test`", 1))
PY
(cd "$tmpdir/opencode" && node scripts/check-harness.mjs)
```

- Expected: checker fails with a clear missing documented command message.
- Result: pass.

### Scenario 4 - Public repository check

- Evidence type: `static_contract`
- Command from repository root:

```bash
./scripts/check.sh
```

- Expected: required files, packaged harness checks, and private-data scan pass.
- Result: pass.

### Scenario 5 - Whitespace safety

- Evidence type: `static_contract`
- Command from repository root:

```bash
git diff --check
```

- Expected: no whitespace errors.
- Result: pass.

## Results summary

| Scenario | Type | Status |
| --- | --- | --- |
| Script syntax | static_contract | pass |
| Harness contract check | static_contract | pass |
| Negative doc coverage control | static_contract | pass |
| Public repository check | static_contract | pass |
| Whitespace safety | static_contract | pass |

## Residual risk

This iteration proves the checker catches local documentation drift. It does not
prove any runtime routing change, and none was intended.
