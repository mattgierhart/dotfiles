#!/bin/bash
# context-density-gate.sh — UserPromptSubmit hook
# Lightweight advisory check on user prompts.
# Warns if prompt appears to contain secrets or sensitive patterns.

set -euo pipefail

input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt // ""')

# Check for common secret patterns in prompts
secret_patterns=(
  'API_KEY'
  'SECRET_KEY'
  'PRIVATE_KEY'
  'PASSWORD'
  'TOKEN='
  'Bearer '
  'sk-'
  'ghp_'
  'ghs_'
)

for pattern in "${secret_patterns[@]}"; do
  if echo "$prompt" | grep -qi "$pattern"; then
    echo "Warning: Prompt may contain sensitive data (matched pattern: $pattern). Avoid pasting secrets directly." >&2
    break
  fi
done

# Always pass through — this is advisory only
exit 0
