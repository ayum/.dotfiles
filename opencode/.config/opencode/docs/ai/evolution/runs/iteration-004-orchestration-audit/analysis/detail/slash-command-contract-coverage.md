# Pattern: Versioned slash-command contracts do not cover all command files

## Observed evidence

- `docs/ai/harness/README.md:7-13` declares `commands.md` as the source of truth for command contracts.
- `docs/ai/harness/commands.md` covers free-form messages, `/feature`, `/scope`, `/design`, `/evolve`, and `/review`.
- Repository command files also include `commands/research.md`, `commands/spec.md`, and `commands/implement.md`.
- `AGENTS.md:10` and `docs/ai/harness/commands.md:11` mention `/spec` as a possible route, but `commands.md` has no `/spec` section.
- `commands/spec.md` delegates directly to `specifier`, while `docs/ai/harness/agents.md:11,22` says specifier must wait when research/design is critical.

## Expected behavior

Every visible slash command should either have a contract in the versioned source of truth or be explicitly classified as auxiliary/subtask with inherited barriers. This is needed for routing evaluation and check coverage.

## Root cause

The harness split command files from versioned contract docs without a coverage invariant. As a result, new or auxiliary commands can exist outside the declared source of truth.

## Affected component level

`memory` primarily (`docs/ai/harness/commands.md` as persistent contract map), with possible `command` updates for `/research`, `/spec`, `/implement` if their own files need guardrails.

## Candidate remediation

- Add sections or an auxiliary-command policy for `/research`, `/spec`, and `/implement` in `docs/ai/harness/commands.md`.
- Explicitly state inherited blockers: `/spec` cannot bypass required research/design; `/implement` requires approved task/spec or clear direct scope; `/research` does not implement.
- Consider extending `check-harness` to detect undocumented `commands/*.md` or require an allowlist of auxiliary commands.

## Confidence

High. File coverage mismatch is directly observable.

## Evidence that would falsify it

- A documented policy elsewhere saying `docs/ai/harness/commands.md` intentionally covers only top-level commands and excludes `subtask: true` commands.
- Hidden command discovery behavior that prevents `/research`, `/spec`, and `/implement` from being user-visible slash commands. No such evidence was found.

## Evidence sufficiency for evolver

Sufficient for a manifest proposing memory/command documentation and/or a coverage check. Post-change replay is recommended if routing behavior is changed; static check is enough if only the source-of-truth coverage is documented.
