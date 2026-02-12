# context-validation.sh

## Purpose

SessionStart hook that validates core project files exist and provides a session context summary. Helps orient the agent at the beginning of each session.

## Trigger

**Event:** `SessionStart`
**Timeout:** 10 seconds

## Behavior

1. Reads JSON input from stdin (includes `source` field: `startup`, `resume`, `clear`, `compact`)
2. Checks that `CLAUDE.md`, `SoT/`, and `README.md` exist
3. On `startup` source, prints a summary to stderr:
   - Number of managed dotfiles (`dot_*` files)
   - Current branch and last commit
   - Number of SoT documents
   - Active epic count (if any)

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success — always passes (advisory only) |
| `1` | Script error (e.g., `jq` not found) |

## Dependencies

- `jq` — JSON parsing
- `git` — commit info and branch detection
- `find` — file counting

## Manual Testing

```bash
echo '{"source": "startup"}' | CLAUDE_PROJECT_DIR=/path/to/dotfiles bash .claude/hooks/context-validation.sh
echo '{"source": "resume"}' | CLAUDE_PROJECT_DIR=/path/to/dotfiles bash .claude/hooks/context-validation.sh
```
