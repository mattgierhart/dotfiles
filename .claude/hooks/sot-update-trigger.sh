#!/bin/bash
# sot-update-trigger.sh — Stop hook
# Detects if dotfiles have been modified without corresponding SoT updates.
# Outputs advisory reminders to stderr.

set -euo pipefail

input=$(cat)

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

# Skip if SoT directory doesn't exist yet
if [[ ! -d "$PROJECT_DIR/SoT" ]]; then
  exit 0
fi

# Find the most recent SoT modification time
latest_sot=0
while IFS= read -r -d '' file; do
  mtime=$(stat -c %Y "$file" 2>/dev/null || stat -f %m "$file" 2>/dev/null || echo 0)
  if [[ "$mtime" -gt "$latest_sot" ]]; then
    latest_sot=$mtime
  fi
done < <(find "$PROJECT_DIR/SoT" -name '*.md' -print0 2>/dev/null)

# Find dotfiles modified more recently than latest SoT update
stale_files=()
while IFS= read -r -d '' file; do
  mtime=$(stat -c %Y "$file" 2>/dev/null || stat -f %m "$file" 2>/dev/null || echo 0)
  if [[ "$mtime" -gt "$latest_sot" && "$latest_sot" -gt 0 ]]; then
    stale_files+=("$(basename "$file")")
  fi
done < <(find "$PROJECT_DIR" -maxdepth 1 -name 'dot_*' -print0 2>/dev/null)

# Also check CLAUDE.md and README.md
for doc in CLAUDE.md README.md; do
  if [[ -f "$PROJECT_DIR/$doc" ]]; then
    mtime=$(stat -c %Y "$PROJECT_DIR/$doc" 2>/dev/null || stat -f %m "$PROJECT_DIR/$doc" 2>/dev/null || echo 0)
    if [[ "$mtime" -gt "$latest_sot" && "$latest_sot" -gt 0 ]]; then
      stale_files+=("$doc")
    fi
  fi
done

if [[ ${#stale_files[@]} -gt 0 ]]; then
  echo "SoT Reminder: The following files changed since last SoT update: ${stale_files[*]}" >&2
  echo "Consider updating the relevant SoT/ documents to keep decisions current." >&2
fi

# Advisory only — do not block
exit 0
