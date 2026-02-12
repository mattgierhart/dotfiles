---
id: EPIC-XXX
title: "{Epic Title}"
status: planned | in-progress | complete
branch: epic/EPIC-XXX-{slug}
created: YYYY-MM-DD
completed:
---

# EPIC-XXX: {Epic Title}

> One-line summary of what this epic accomplishes.

---

## Section 0: Context Capsule

Pre-load these files at session start:

- `CLAUDE.md`
- `SoT/{relevant-file}.md`
- {List any specific dotfiles or configs this epic touches}

## Section 1: Session State

> Updated at every checkpoint and session boundary.

| Field | Value |
|-------|-------|
| **Last Action** | {What was just completed — reference IDs} |
| **Stopping Point** | {Current file/line where work paused} |
| **Next Steps** | {What comes next} |
| **Decisions Made** | {Choices made with rationale} |
| **Resume Instructions** | {Exact first steps for next session} |

---

## Goal

{What does this epic achieve? Why is it needed?}

## Affected Files

| File | Change Type | Notes |
|------|-------------|-------|
| `dot_zshrc` | modify | {What changes} |
| `dot_config/...` | create/modify | {What changes} |

## Target Machines

- [ ] Mac Studio
- [ ] MacBook Pro

## Steps

### 1. {Step Name}

{Description of what to do}

**SoT entries to create/update:**
- `{PREFIX}-{NNN}`: {Brief description}

### 2. {Step Name}

{Description}

### 3. Verification

- [ ] Shell syntax valid: `zsh -n dot_zshrc`
- [ ] Config sourced successfully: `source dot_zshrc`
- [ ] Tool available: `command -v {tool}`
- [ ] No secrets in tracked files: run `dotfiles-sync-check`
- [ ] SoT entries created/updated
- [ ] README updated (if new tool or feature)

### 4. Rollback Plan

{How to revert if something goes wrong}

```bash
git revert HEAD  # or specific rollback steps
```

---

## Change Log

| Date | Action | IDs |
|------|--------|-----|
| YYYY-MM-DD | Epic created | — |
