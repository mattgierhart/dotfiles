#!/bin/bash
# context-validation.sh — SessionStart hook
# Validates core project files exist and prints a session context summary.

set -euo pipefail

input=$(cat)
source=$(echo "$input" | jq -r '.source // "startup"')

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

# Core file checks
missing=()
[[ -f "$PROJECT_DIR/CLAUDE.md" ]] || missing+=("CLAUDE.md")
[[ -d "$PROJECT_DIR/SoT" ]] || missing+=("SoT/")
[[ -f "$PROJECT_DIR/README.md" ]] || missing+=("README.md")

if [[ ${#missing[@]} -gt 0 ]]; then
  echo "Warning: Missing core files: ${missing[*]}" >&2
fi

# On full startup, print context summary
if [[ "$source" == "startup" ]]; then
  echo "--- Dotfiles Session Context ---" >&2

  # Count managed dotfiles
  dotfile_count=$(find "$PROJECT_DIR" -maxdepth 1 -name 'dot_*' 2>/dev/null | wc -l | tr -d ' ')
  echo "Managed dotfiles: $dotfile_count" >&2

  # Last commit info
  if git -C "$PROJECT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
    last_commit=$(git -C "$PROJECT_DIR" log -1 --format="%h %s (%cr)" 2>/dev/null || echo "no commits")
    branch=$(git -C "$PROJECT_DIR" branch --show-current 2>/dev/null || echo "detached")
    echo "Branch: $branch" >&2
    echo "Last commit: $last_commit" >&2
  fi

  # SoT file count
  if [[ -d "$PROJECT_DIR/SoT" ]]; then
    sot_count=$(find "$PROJECT_DIR/SoT" -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
    echo "SoT documents: $sot_count" >&2
  fi

  # Active epic check
  active_epics=$(find "$PROJECT_DIR/epics" -name 'EPIC-*.md' 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$active_epics" -gt 0 ]]; then
    echo "Active epics: $active_epics" >&2
  fi

  echo "--------------------------------" >&2
fi

exit 0
