---
name: ghm-status-sync
description: Synchronizes documentation across SoT files, README.md, and CLAUDE.md when dotfiles change. Use after making configuration changes to ensure all documentation stays consistent.
---

# Status Sync

Ensures that SoT documents, README, and CLAUDE.md remain consistent after configuration changes.

## Prerequisites

- Configuration changes have been made (dotfiles modified, tools added/removed)
- Changes are ready to be reflected across documentation

## Workflow

### 1. Identify What Changed

```bash
git diff --name-only
git diff --cached --name-only
```

Categorize changes:
- **Dotfile changes** (`dot_*`) → May need SoT updates
- **SoT changes** (`SoT/`) → May need README/CLAUDE.md updates
- **Doc changes** (`README.md`, `CLAUDE.md`) → May need SoT cross-references

### 2. Sync SoT from Dotfiles

If `dot_*` files changed:

| Change Type | SoT Action |
|-------------|------------|
| New tool added to `dot_zshrc` | Add `TOOL-` entry to `SoT/tool-inventory.md` |
| New config decision | Add `CFG-` entry to `SoT/config-decisions.md` |
| Security-related change | Update `SoT/security-model.md` |
| Platform-specific path | Update `SoT/machine-compatibility.md` |
| Shell startup order changed | Update `SoT/shell-architecture.md` |

### 3. Sync README from SoT

If SoT files changed, verify README reflects:

- [ ] **What's Included** section lists all tools from `SoT/tool-inventory.md`
- [ ] **Files Managed** section matches actual `dot_*` files
- [ ] **Security Note** aligns with `SoT/security-model.md`

### 4. Sync CLAUDE.md

If the ID scheme or hook inventory changed:

- [ ] **Hook Inventory** table matches `.claude/settings.json`
- [ ] **ID Ownership** section matches actual SoT files
- [ ] **Document Ecosystem** paths are correct

### 5. Update Frontmatter

For each modified SoT file:
- Increment `version` (minor bump for additions, patch for corrections)
- Update `last-updated` to today's date

### 6. Verify

Run a quick cross-check:

```bash
# Ensure all TOOL- entries have corresponding tool in dot_zshrc or mise config
grep 'TOOL-' SoT/tool-inventory.md
# Compare against actual tools
grep -E 'brew|mise|source' dot_zshrc
```

## References

- `README.md` — Dashboard and status
- `CLAUDE.md` — Agent operating instructions
- `SoT/` — Source of Truth files
