---
version: 0.1
last-updated: 2026-02-12
status: active
---

# Configuration Decisions

Durable record of configuration choices and their rationale. Each entry uses the `CFG-` prefix.

---

## CFG-001: chezmoi for Dotfile Management

**Decision:** Use [chezmoi](https://www.chezmoi.io/) as the dotfile manager.
**Rationale:** Supports templating for machine-specific config, encryption for secrets, cross-platform sync, and declarative file management. Preferred over bare git repos, stow, or yadm for its template engine and security features.
**Date:** 2026-02-12
**Refs:** COMPAT-001

## CFG-002: mise for Tool Version Management

**Decision:** Use [mise](https://mise.jdx.dev/) (formerly rtx) as the universal version manager.
**Rationale:** Single tool replaces nvm, pyenv, rbenv, etc. Faster than asdf (Rust-based), compatible with `.tool-versions` files, supports environment variables via `[env]` config.
**Date:** 2026-02-12
**Refs:** TOOL-001, CFG-003

## CFG-003: Dual Version Manager Coexistence (NVM + mise)

**Decision:** Keep NVM alongside mise during transition period.
**Rationale:** NVM is still sourced in `dot_zshrc` for backward compatibility with projects that expect `nvm` commands. mise handles the global Node LTS version. Once all projects migrate to mise, NVM can be removed.
**Date:** 2026-02-12
**Refs:** CFG-002, TOOL-001, TOOL-005

## CFG-004: VS Code as Default Editor

**Decision:** Set `EDITOR=code` in mise global config.
**Rationale:** VS Code is the primary editor across both machines. Set via mise `[env]` rather than in `dot_zshrc` to keep shell config focused on shell concerns.
**Date:** 2026-02-12

## CFG-005: Local Secrets Pattern

**Decision:** Machine-specific secrets go in `~/.zshrc.local`, never in tracked files.
**Rationale:** The `.zshrc.local` file is sourced at the end of `dot_zshrc` but is not managed by chezmoi or committed to git. This allows per-machine API keys, tokens, and environment overrides without leaking to the repo.
**Date:** 2026-02-12
**Refs:** SEC-001, SEC-002
