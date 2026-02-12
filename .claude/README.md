# .claude/ — Project Configuration

> Claude Code configuration for the dotfiles repository, adapted from the [PRD-driven-context-engineering](https://github.com/mattgierhart/PRD-driven-context-engineering) template methodology.

---

## Directory Structure

```text
.claude/
├── settings.json           # Hook registration and permissions
├── README.md               # This file
├── hooks/                  # Lifecycle automation scripts
│   ├── context-validation.sh/.md     # SessionStart
│   ├── context-density-gate.sh/.md   # UserPromptSubmit
│   ├── sot-update-trigger.sh/.md     # Stop
│   ├── subagent-memory-load.sh/.md   # SubagentStart
│   └── subagent-memory-save.sh/.md   # SubagentStop
└── skills/                 # Guidance documents and workflows
    ├── skills-inventory.md
    ├── SKILL_TEMPLATE/
    ├── ghm-gate-check/
    ├── ghm-id-register/
    ├── ghm-status-sync/
    ├── ghm-sot-builder/
    ├── dotfiles-add-tool/
    └── dotfiles-sync-check/
```

---

## Hooks

Hooks are shell scripts triggered by Claude Code lifecycle events. Each hook has a companion `.md` file documenting its purpose, behavior, and exit codes.

| Hook | Event | Timeout | Purpose |
|------|-------|---------|---------|
| `context-validation.sh` | SessionStart | 10s | Validates core files (CLAUDE.md, SoT/) exist; prints session context summary |
| `context-density-gate.sh` | UserPromptSubmit | 10s | Advisory check for secrets patterns in prompts |
| `sot-update-trigger.sh` | Stop | 15s | Detects stale SoT entries when dotfiles have changed |
| `subagent-memory-load.sh` | SubagentStart | 5s | Loads CLAUDE.md context and active epic for subagents |
| `subagent-memory-save.sh` | SubagentStop | 5s | Captures subagent decisions to session log |

**Exit code semantics:**
- `0` — Success / pass-through (advisory messages go to stderr)
- `1` — Error (hook failed to execute)
- `2` — Block the action (used sparingly; currently no hooks block)

**Relationship to global config:** The global config at `~/.claude/settings.json` runs a Stop hook (`stop-hook-git-check.sh`) that validates uncommitted/unpushed changes. This project-level config runs **alongside** the global config — both fire for their respective events. They serve different purposes: the global hook enforces git discipline; these project hooks manage documentation and SoT integrity.

---

## Skills

Skills are structured guidance documents that Claude Code follows when performing specific workflows. Each skill directory contains a `SKILL.md` file with step-by-step instructions.

### Methodology Skills (adapted from template)

| Skill | Purpose |
|-------|---------|
| `ghm-gate-check` | Validates completeness before committing config changes |
| `ghm-id-register` | Manages unique ID references across SoT files |
| `ghm-status-sync` | Synchronizes SoT, README, and CLAUDE.md when dotfiles change |
| `ghm-sot-builder` | Builds and updates Source of Truth documents |

### Dotfiles-Specific Skills

| Skill | Purpose |
|-------|---------|
| `dotfiles-add-tool` | End-to-end workflow for adding a new tool to the stack |
| `dotfiles-sync-check` | Validates chezmoi state and checks for secrets in tracked files |

### Skill Structure

Each skill follows the template pattern:
```text
skill-name/
└── SKILL.md    # Frontmatter (name, description) + workflow steps
```

See `SKILL_TEMPLATE/SKILL.md` for the format when creating new skills.

---

## ID System

This repo uses a simplified ID scheme adapted from the template's 23-prefix system:

| Prefix | Domain | SoT File |
|--------|--------|----------|
| `CFG-` | Configuration decisions | `SoT/config-decisions.md` |
| `TOOL-` | Tool choices and rationale | `SoT/tool-inventory.md` |
| `SEC-` | Security decisions | `SoT/security-model.md` |
| `COMPAT-` | Cross-machine compatibility | `SoT/machine-compatibility.md` |

IDs are referenced in SoT files, CLAUDE.md, and optionally in code comments for traceability.
