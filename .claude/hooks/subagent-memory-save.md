# subagent-memory-save.sh

## Purpose

SubagentStop hook that captures subagent session metadata to a log file in `temp/`. Provides continuity by recording what files were touched during each subagent delegation.

## Trigger

**Event:** `SubagentStop`
**Timeout:** 5 seconds

## Behavior

1. Reads JSON input from stdin (includes `session_id`)
2. Creates `temp/subagent-log.md` if it doesn't exist
3. Appends a session entry with:
   - Session ID and timestamp
   - List of files modified or staged during the subagent session
4. The log file lives in `temp/` which is gitignored — it's ephemeral session data

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success — always passes |
| `1` | Script error |

## Dependencies

- `jq` — JSON parsing
- `git` — change detection
- `date` — timestamp generation

## Manual Testing

```bash
echo '{"session_id": "test-123"}' | CLAUDE_PROJECT_DIR=/path/to/dotfiles bash .claude/hooks/subagent-memory-save.sh
cat temp/subagent-log.md
```
