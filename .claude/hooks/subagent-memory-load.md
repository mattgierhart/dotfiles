# subagent-memory-load.sh

## Purpose

SubagentStart hook that loads relevant project context for subagent consumption. Provides a compact context summary so subagents understand the project structure, ID scheme, and current state.

## Trigger

**Event:** `SubagentStart`
**Timeout:** 5 seconds

## Behavior

1. Reads JSON input from stdin
2. Outputs a context summary to stderr including:
   - Project identity (dotfiles repo, chezmoi-managed)
   - Target machines
   - Current git branch
   - ID prefix scheme (CFG-, TOOL-, SEC-, COMPAT-)
   - SoT file paths
   - Active epic (if any)

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success — always passes |
| `1` | Script error |

## Dependencies

- `jq` — JSON parsing
- `git` — branch detection
- `find` — epic discovery

## Manual Testing

```bash
echo '{}' | CLAUDE_PROJECT_DIR=/path/to/dotfiles bash .claude/hooks/subagent-memory-load.sh
```
