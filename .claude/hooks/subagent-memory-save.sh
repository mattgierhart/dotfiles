#!/bin/bash
# subagent-memory-save.sh — SubagentStop hook
# Captures subagent session metadata to a session log in temp/.
# Lightweight capture for continuity across delegations.

set -euo pipefail

input=$(cat)

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
TEMP_DIR="$PROJECT_DIR/temp"

# Ensure temp directory exists
mkdir -p "$TEMP_DIR"

# Extract session info
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%SZ")

# Append to session log
log_file="$TEMP_DIR/subagent-log.md"

{
  echo ""
  echo "## Subagent Session: $session_id"
  echo "**Timestamp:** $timestamp"

  # Log any git changes made during the subagent session
  if git -C "$PROJECT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
    changed_files=$(git -C "$PROJECT_DIR" diff --name-only 2>/dev/null || true)
    staged_files=$(git -C "$PROJECT_DIR" diff --cached --name-only 2>/dev/null || true)
    if [[ -n "$changed_files" || -n "$staged_files" ]]; then
      echo "**Files touched:**"
      if [[ -n "$staged_files" ]]; then
        echo "$staged_files" | while read -r f; do echo "- [staged] $f"; done
      fi
      if [[ -n "$changed_files" ]]; then
        echo "$changed_files" | while read -r f; do echo "- [modified] $f"; done
      fi
    else
      echo "**Files touched:** none"
    fi
  fi

  echo ""
} >> "$log_file"

exit 0
