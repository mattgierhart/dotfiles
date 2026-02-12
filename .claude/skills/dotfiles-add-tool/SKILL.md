---
name: dotfiles-add-tool
description: End-to-end workflow for adding a new tool to the dotfiles stack. Use when the user wants to add a new CLI tool, shell integration, or development utility to their managed configuration.
---

# Add Tool

Complete workflow for adding a new tool to the dotfiles stack, covering mise configuration, shell integration, documentation, and verification.

## Prerequisites

- Tool name and purpose identified
- Confirmation that the tool should be synced across machines (vs. machine-local)

## Workflow

### 1. Determine Installation Method

| Method | When to Use |
|--------|-------------|
| mise (in `dot_config/mise/private_config.toml`) | Version-managed CLI tools (node, python, go, etc.) |
| Homebrew (in README setup instructions) | System utilities (jq, ripgrep, fzf, bat, etc.) |
| Shell plugin | Zsh plugins or completions |
| Direct download | Tools not in package managers |

### 2. Add to mise (if version-managed)

Edit `dot_config/mise/private_config.toml`:

```toml
[tools]
# existing tools...
{tool} = "latest"  # or specific version
```

### 3. Add Shell Integration

Edit `dot_zshrc` to add the tool's shell integration:

```bash
# {Tool Name} - {brief description}
# @implements TOOL-{NNN}
eval "$({tool} init zsh)"  # or source, PATH addition, alias, etc.
```

### 4. Create SoT Entry

Use the `ghm-id-register` skill to create a new `TOOL-` entry in `SoT/tool-inventory.md`:

- Tool name and version
- Installation method
- Integration type (PATH, eval, source, alias)
- Why this tool was chosen (over alternatives)
- Cross-references to related CFG- or COMPAT- entries

### 5. Update README

Add the tool to `README.md`:
- **What's Included** section
- **Quick Setup** brew install command (if Homebrew-installed)
- **Files Managed** if a new dotfile was created

### 6. Check Compatibility

Verify the tool works on both target machines:
- [ ] Homebrew path compatible (`/opt/homebrew` on ARM Mac)
- [ ] No hard-coded paths
- [ ] Falls back gracefully if tool is missing (e.g., `command -v {tool} && ...`)

### 7. Test

```bash
# Source the updated zshrc
source dot_zshrc

# Verify tool is available
command -v {tool}
{tool} --version
```

### 8. Run Status Sync

Use the `ghm-status-sync` skill to ensure all documentation is consistent.

### 9. Commit

```
feat: add {tool} to dotfiles stack

- Add to mise config / brew install list
- Add shell integration to dot_zshrc
- Create TOOL-{NNN} SoT entry
- Update README
```

## References

- `SoT/tool-inventory.md` — Tool registry
- `SoT/machine-compatibility.md` — Platform compatibility
- `ghm-id-register/` — ID registration
- `ghm-status-sync/` — Documentation sync
