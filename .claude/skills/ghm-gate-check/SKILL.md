---
name: ghm-gate-check
description: Validates completeness before committing configuration changes. Use when finalizing a set of dotfile modifications to ensure all documentation and cross-references are current.
---

# Gate Check

Validates that a configuration change is complete and properly documented before committing.

## Prerequisites

- Changes to `dot_*` files, `CLAUDE.md`, or `README.md` are staged or in progress
- `SoT/` directory exists with at least one document

## Workflow

### 1. Identify Changed Files

Review all modified, staged, and untracked files:

```bash
git status
git diff --name-only
git diff --cached --name-only
```

### 2. Validate Documentation Coverage

For each changed dotfile, verify:

- [ ] **SoT entry exists**: If a new tool or config decision was made, a corresponding `CFG-`, `TOOL-`, `SEC-`, or `COMPAT-` entry exists in the appropriate SoT file
- [ ] **Cross-references are valid**: Any IDs referenced in the change exist in SoT files
- [ ] **README is current**: If a new tool was added, it appears in the README's "What's Included" section
- [ ] **No secrets**: No API keys, tokens, or passwords are present in tracked files

### 3. Validate Config Syntax

For shell configuration files:

```bash
# Check zshrc syntax (basic validation)
zsh -n dot_zshrc 2>&1 || echo "Syntax issues found"
```

For chezmoi templates (if applicable):

```bash
chezmoi execute-template < file.tmpl
```

### 4. Cross-Machine Compatibility

If changes affect paths or platform-specific features:

- [ ] Paths work on both Mac Studio and MacBook Pro
- [ ] Homebrew prefix is handled correctly (`/opt/homebrew` vs `/usr/local`)
- [ ] No hard-coded machine-specific values (use `.zshrc.local` for those)

### 5. Report

Output a summary:
- Files changed
- SoT entries created/updated
- Any gaps or warnings found
- Ready to commit: yes/no

## References

- `SoT/config-decisions.md` — CFG- entries
- `SoT/tool-inventory.md` — TOOL- entries
- `SoT/security-model.md` — SEC- entries
- `SoT/machine-compatibility.md` — COMPAT- entries
