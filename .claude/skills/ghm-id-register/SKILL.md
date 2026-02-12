---
name: ghm-id-register
description: Validates and registers new unique IDs in Source of Truth files. Use when creating new SoT entries to ensure ID uniqueness and proper formatting.
---

# ID Register

Manages the unique ID system across all SoT files. Validates new IDs, checks for duplicates, and ensures consistent formatting.

## Prerequisites

- `SoT/` directory exists with at least one document
- A new configuration decision, tool addition, security policy, or compatibility note needs to be recorded

## ID Scheme

| Prefix | Domain | File | Format |
|--------|--------|------|--------|
| `CFG-` | Configuration decisions | `SoT/config-decisions.md` | `CFG-001` through `CFG-999` |
| `TOOL-` | Tool choices | `SoT/tool-inventory.md` | `TOOL-001` through `TOOL-999` |
| `SEC-` | Security decisions | `SoT/security-model.md` | `SEC-001` through `SEC-999` |
| `COMPAT-` | Compatibility notes | `SoT/machine-compatibility.md` | `COMPAT-001` through `COMPAT-999` |

## Workflow

### 1. Determine ID Type

Based on the decision being recorded:
- **Configuration choice** (e.g., "use chezmoi") → `CFG-`
- **Tool selection** (e.g., "add ripgrep") → `TOOL-`
- **Security policy** (e.g., "secrets in .zshrc.local") → `SEC-`
- **Platform compatibility** (e.g., "Homebrew path differs on ARM") → `COMPAT-`

### 2. Find Next Available ID

Scan the target SoT file for existing IDs and determine the next sequential number:

```bash
grep -oP '(CFG|TOOL|SEC|COMPAT)-\d+' SoT/*.md | sort -t- -k2 -n | tail -5
```

### 3. Validate Uniqueness

Ensure the new ID does not already exist anywhere in the repo:

```bash
grep -r "CFG-XXX" SoT/ CLAUDE.md README.md
```

### 4. Register the Entry

Add the entry to the appropriate SoT file following this format:

```markdown
## {PREFIX}-{NUMBER}: {Short Title}

**Decision:** What was decided
**Rationale:** Why this decision was made
**Date:** YYYY-MM-DD
**Refs:** Related IDs (e.g., "See TOOL-001, COMPAT-002")
```

### 5. Update Frontmatter

Increment the version and update `last-updated` in the SoT file's YAML frontmatter.

### 6. Cross-Reference

If the new ID relates to existing entries, add cross-references in both directions.

## References

- `.claude/README.md` — ID system overview
- `SoT/` — All Source of Truth files
