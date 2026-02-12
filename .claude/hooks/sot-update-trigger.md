# sot-update-trigger.sh

## Purpose

Stop hook that detects when dotfiles have been modified without corresponding updates to Source of Truth documents. Outputs advisory reminders to help maintain documentation currency.

## Trigger

**Event:** `Stop`
**Timeout:** 15 seconds

## Behavior

1. Reads JSON input from stdin
2. Finds the most recent modification time across all `SoT/*.md` files
3. Checks if any `dot_*` files, `CLAUDE.md`, or `README.md` have been modified more recently
4. If drift is detected, outputs a reminder to stderr listing the stale files
5. Always exits 0 — advisory only, does not block session end

**Note:** The global Stop hook at `~/.claude/stop-hook-git-check.sh` handles git commit/push validation separately. This hook focuses solely on SoT documentation currency.

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success — always passes (advisory only) |
| `1` | Script error |

## Dependencies

- `jq` — JSON parsing
- `stat` — file modification times (supports both GNU and BSD variants)
- `find` — file discovery

## Manual Testing

```bash
# Modify a dotfile then run:
echo '{}' | CLAUDE_PROJECT_DIR=/path/to/dotfiles bash .claude/hooks/sot-update-trigger.sh

# Update SoT then run again — should produce no warning:
touch SoT/config-decisions.md
echo '{}' | CLAUDE_PROJECT_DIR=/path/to/dotfiles bash .claude/hooks/sot-update-trigger.sh
```
