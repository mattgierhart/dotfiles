| title | updated | authority |
|-------|---------|-----------|
| Agent Operating Guide — Dotfiles | 2026-02-12 | PRD-Led Context Engineering (adapted) |

# CLAUDE.md — Agent Operating Guide

> **Mission**: Maintain a clean, secure, cross-machine dotfiles configuration.
> **Authority**: Load `README.md` → `CLAUDE.md` → Active EPIC (if any).
> **Core Rule**: If it's not in the SoT, the decision doesn't exist.

---

## 1. Session Protocols (MANDATORY)

### Start of Session

1. **Load Context**: Read `README.md` and this file (`CLAUDE.md`).
2. **Check SoT**: Confirm `SoT/` directory exists and files are readable.
3. **Check Git Status**: Confirm you are on the correct branch.
4. **Check Active Epic**: Look for `epics/EPIC-*.md` files. If one exists, read Section 1 for resume instructions.

### During Session (Checkpoint Discipline)

After meaningful changes:

1. **Update SoT**: If a configuration decision was made, record it in the appropriate SoT file before moving on.
2. **Commit progress**: Use clear commit messages referencing IDs where applicable.
3. **Test changes**: Source modified shell files or validate syntax before committing.

### End of Session

1. **Update Active Epic** (if one exists): Record what was done, where work stopped, and what comes next.
2. **Commit**: Ensure all changes are committed and pushed.
3. **SoT check**: The Stop hook will remind you if SoT files are stale.

---

## 2. Document Ecosystem

| Layer | Files | Purpose |
|-------|-------|---------|
| **Navigation** | `README.md` | Dashboard — what's managed, quick setup, status |
| **Operating Guide** | `CLAUDE.md` | This file — rules, protocols, ID scheme |
| **Knowledge** | `SoT/*.md` | Source of Truth — durable decisions with unique IDs |
| **Working Memory** | `epics/EPIC-*.md` | Active work — multi-step config changes |
| **Scratchpad** | `temp/` | Ephemeral notes — gitignored, session-scoped |

### ID Ownership

| Prefix | Domain | Owner File |
|--------|--------|------------|
| `CFG-` | Configuration decisions | `SoT/config-decisions.md` |
| `TOOL-` | Tool choices and rationale | `SoT/tool-inventory.md` |
| `SEC-` | Security decisions | `SoT/security-model.md` |
| `COMPAT-` | Cross-machine compatibility | `SoT/machine-compatibility.md` |

**Cross-Reference Rule**: Every ID should link to related IDs where applicable. This creates a knowledge graph that agents can traverse.

---

## 3. Dotfiles-Specific Rules

### Security (MANDATORY)

- **Never commit secrets**: No API keys, tokens, passwords, or private keys in tracked files.
- **Secret storage**: Use `.zshrc.local` (machine-specific, not synced) or `.mise.local.toml` (project-specific, gitignored).
- **Audit before commit**: The `dotfiles-sync-check` skill can scan for secret patterns.
- **Reference**: See `SoT/security-model.md` for the full security policy.

### Cross-Machine Compatibility

- **Target machines**: Mac Studio and MacBook Pro.
- **No hard-coded paths**: Use variables or conditional logic for platform differences (e.g., Homebrew prefix on ARM vs Intel).
- **Graceful degradation**: Use `command -v {tool} && ...` patterns so missing tools don't break shell startup.
- **Machine-specific config**: Put machine-specific settings in `.zshrc.local` (sourced at end of `dot_zshrc`, not tracked).
- **Reference**: See `SoT/machine-compatibility.md`.

### Configuration Hygiene

- **Test before committing**: Source modified shell files (`source dot_zshrc`) or use `zsh -n dot_zshrc` for syntax validation.
- **One concern per file**: Keep `dot_zshrc` focused on shell config; tool-specific config goes in `dot_config/`.
- **Comment rationale, not mechanics**: Comments should explain *why*, not *what*.
- **chezmoi conventions**: Files follow chezmoi naming (`dot_` prefix, `private_` prefix for private files).

---

## 4. Hook Inventory

| Hook | Event | Timeout | Purpose |
|------|-------|---------|---------|
| `context-validation.sh` | SessionStart | 10s | Validates core files exist; prints session context |
| `context-density-gate.sh` | UserPromptSubmit | 10s | Advisory: warns about potential secrets in prompts |
| `sot-update-trigger.sh` | Stop | 15s | Advisory: reminds about stale SoT entries |
| `subagent-memory-load.sh` | SubagentStart | 5s | Loads project context for subagents |
| `subagent-memory-save.sh` | SubagentStop | 5s | Captures subagent decisions to session log |

**Global hook** (runs alongside project hooks): `~/.claude/stop-hook-git-check.sh` validates uncommitted/unpushed changes at session end.

---

## 5. Branch Convention

For multi-step configuration changes, use epics with dedicated branches:

**Naming**: `epic/EPIC-{NUMBER}-{slug}`

Examples:
- `epic/EPIC-01-add-neovim-config`
- `epic/EPIC-02-migrate-shell-plugins`
- `epic/EPIC-03-ssh-key-management`

**Workflow**:
1. Create epic file from `epics/EPIC_TEMPLATE.md`
2. Create branch: `git checkout -b epic/EPIC-{NUMBER}-{slug}`
3. Work and commit, referencing IDs in commit messages
4. Complete epic → PR opened
5. Merge → Branch deleted, epic marked Complete

For small changes (single-commit fixes), skip the epic workflow and commit directly.

---

## 6. Context Management

### Just-In-Time Context (JIT-C)

- **Reference by ID**: Use `CFG-001`, `TOOL-002` as retrieval handles, not full document dumps.
- **Load on demand**: Read SoT files only when reasoning requires specific decisions.
- **Summarize at boundaries**: Epic handoffs include 75-word summaries, not full content.

### Context Efficiency

- **Batch operations**: Plan comprehensive changes before executing piecemeal.
- **Consolidation**: Run validation checks in bulk rather than one at a time.
- **Pruning**: If context fills, checkpoint to the epic and suggest a session handoff.

---

## 7. Quick Reference

| Resource | Path |
|----------|------|
| Skills Inventory | `.claude/skills/skills-inventory.md` |
| Hook Documentation | `.claude/hooks/*.md` |
| SoT Index | `SoT/` directory |
| Epic Template | `epics/EPIC_TEMPLATE.md` |
| ID System | `.claude/README.md` (ID System section) |
| Project Config | `.claude/settings.json` |
