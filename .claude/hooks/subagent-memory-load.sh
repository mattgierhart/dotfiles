#!/bin/bash
# subagent-memory-load.sh — SubagentStart hook
# Loads relevant project context for subagent consumption.
# Outputs context summary that the subagent can reference.

set -euo pipefail

input=$(cat)

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

# Output key context for the subagent
{
  echo "=== Dotfiles Project Context ==="

  # Project identity
  echo "Repository: Matt's Dotfiles (chezmoi-managed)"
  echo "Machines: Mac Studio, MacBook Pro"

  # Current branch
  if git -C "$PROJECT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git -C "$PROJECT_DIR" branch --show-current 2>/dev/null || echo "unknown")
    echo "Branch: $branch"
  fi

  # ID scheme reminder
  echo ""
  echo "ID Prefixes: CFG- (config), TOOL- (tools), SEC- (security), COMPAT- (compatibility)"
  echo "SoT files: SoT/config-decisions.md, SoT/tool-inventory.md, SoT/security-model.md, SoT/machine-compatibility.md, SoT/shell-architecture.md"

  # Active epic (if any)
  if [[ -d "$PROJECT_DIR/epics" ]]; then
    active=$(find "$PROJECT_DIR/epics" -name 'EPIC-*.md' -print -quit 2>/dev/null)
    if [[ -n "$active" ]]; then
      echo ""
      echo "Active Epic: $(basename "$active")"
    fi
  fi

  echo "================================"
} >&2

exit 0
