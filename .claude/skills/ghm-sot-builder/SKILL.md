---
name: ghm-sot-builder
description: Builds and updates Source of Truth documents from current dotfile state. Use when initializing SoT for the first time or when significant configuration changes need to be documented.
---

# SoT Builder

Generates or updates Source of Truth documents by analyzing the current state of dotfiles and configuration.

## Prerequisites

- `SoT/` directory exists
- Dotfiles (`dot_*`) and config files (`dot_config/`) are present

## SoT File Inventory

| File | Content Source |
|------|---------------|
| `config-decisions.md` | Analyze `dot_zshrc`, `dot_config/`, chezmoi patterns → extract design decisions |
| `tool-inventory.md` | Parse `dot_zshrc` for tool integrations, `dot_config/mise/` for managed versions |
| `security-model.md` | Scan for secret patterns, `.local` file references, gitignore rules |
| `machine-compatibility.md` | Detect platform-specific paths, conditional logic, machine targets |
| `shell-architecture.md` | Trace `dot_zshrc` sourcing order, integration points, startup flow |

## Workflow

### 1. Analyze Current State

Read all dotfiles and extract configuration facts:

```bash
# List all managed dotfiles
ls -la dot_*

# Parse mise config for managed tools
cat dot_config/mise/private_config.toml

# Analyze zshrc for integrations
cat dot_zshrc
```

### 2. Build/Update Each SoT File

For each SoT file, follow this pattern:

```markdown
---
version: 0.1
last-updated: {TODAY}
status: active
---

# {Title}

## {PREFIX}-{NNN}: {Decision Title}

**Decision:** {What was decided}
**Rationale:** {Why}
**Date:** {When}
**Refs:** {Related IDs}
```

#### config-decisions.md
Scan for decisions like:
- Package manager choice (chezmoi)
- Shell choice (zsh)
- Plugin management approach
- Configuration split strategy (synced vs. local)

#### tool-inventory.md
For each tool found in dotfiles:
- Tool name and version (from mise config)
- What it does
- How it's integrated (shell alias, PATH, source)
- Why it was chosen

#### security-model.md
Document:
- What's tracked vs. gitignored
- Secret storage strategy (`.zshrc.local`, `.mise.local.toml`)
- Patterns that must never be committed

#### machine-compatibility.md
Identify:
- Target machines and their differences
- Platform-specific paths (Homebrew, etc.)
- Conditional logic in dotfiles

#### shell-architecture.md
Map the startup flow:
- Sourcing order in `dot_zshrc`
- Integration points (mise, fzf, nvm, bun)
- Environment variable hierarchy

### 3. Validate Cross-References

Ensure IDs referenced across files actually exist. Run the `ghm-id-register` skill if new IDs are needed.

### 4. Commit

```
docs: build/update SoT from current dotfile state
```

## References

- `ghm-id-register/` — ID validation and registration
- `ghm-status-sync/` — Follow up with status sync after building SoT
