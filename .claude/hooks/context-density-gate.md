# context-density-gate.sh

## Purpose

UserPromptSubmit hook that performs a lightweight advisory check on prompts. Warns if the prompt appears to contain secrets or sensitive data patterns.

## Trigger

**Event:** `UserPromptSubmit`
**Timeout:** 10 seconds

## Behavior

1. Reads JSON input from stdin (includes `prompt` field)
2. Scans the prompt text for common secret patterns (API keys, tokens, passwords)
3. If a match is found, outputs a warning to stderr
4. Always exits 0 — never blocks prompt submission

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success — always passes (advisory only) |
| `1` | Script error (e.g., `jq` not found) |

## Dependencies

- `jq` — JSON parsing
- `grep` — pattern matching

## Manual Testing

```bash
echo '{"prompt": "Add my API_KEY=abc123 to config"}' | bash .claude/hooks/context-density-gate.sh
echo '{"prompt": "Add fzf keybindings"}' | bash .claude/hooks/context-density-gate.sh
```
