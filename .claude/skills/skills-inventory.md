# Skills Inventory

> Master index of all skills available in this dotfiles repository.

---

## Methodology Skills

Adapted from the [PRD-driven-context-engineering](https://github.com/mattgierhart/PRD-driven-context-engineering) template's `ghm-*` workflow skills.

| Skill | Directory | When to Use |
|-------|-----------|-------------|
| **Gate Check** | `ghm-gate-check/` | Before committing config changes — validates completeness |
| **ID Register** | `ghm-id-register/` | When creating new SoT entries — validates and assigns IDs |
| **Status Sync** | `ghm-status-sync/` | After changes — synchronizes SoT, README, and CLAUDE.md |
| **SoT Builder** | `ghm-sot-builder/` | When adding new tools or configs — generates/updates SoT documents |

## Dotfiles-Specific Skills

Custom skills for configuration management workflows.

| Skill | Directory | When to Use |
|-------|-----------|-------------|
| **Add Tool** | `dotfiles-add-tool/` | Adding a new tool to the dotfiles stack (mise, shell, SoT) |
| **Sync Check** | `dotfiles-sync-check/` | Validating chezmoi state and checking for secrets in tracked files |

## Template

| Skill | Directory | When to Use |
|-------|-----------|-------------|
| **Skill Template** | `SKILL_TEMPLATE/` | Creating a new skill — copy this directory |

---

## ID Scheme

Skills reference and manage these ID prefixes:

| Prefix | Domain | Owner File |
|--------|--------|------------|
| `CFG-` | Configuration decisions | `SoT/config-decisions.md` |
| `TOOL-` | Tool choices and rationale | `SoT/tool-inventory.md` |
| `SEC-` | Security decisions | `SoT/security-model.md` |
| `COMPAT-` | Cross-machine compatibility | `SoT/machine-compatibility.md` |

---

## Creating New Skills

1. Copy `SKILL_TEMPLATE/` to a new directory under `skills/`
2. Edit `SKILL.md` with frontmatter (name, description) and workflow steps
3. Add the skill to this inventory file
4. Commit with message: `skill: add {skill-name}`
