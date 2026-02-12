---
version: 0.1
last-updated: 2026-02-12
status: active
---

# Security Model

Documents security decisions for the dotfiles repository. Each entry uses the `SEC-` prefix.

---

## SEC-001: Secrets Stored in .zshrc.local

**Decision:** All machine-specific secrets (API keys, tokens, credentials) go in `~/.zshrc.local`.
**Rationale:** This file is sourced at the end of `dot_zshrc` but is NOT tracked by chezmoi or committed to git. Each machine maintains its own secrets independently. The `.gitignore` also excludes `*.local` patterns.
**Enforcement:** The `context-density-gate.sh` hook warns if secrets patterns appear in prompts. The `dotfiles-sync-check` skill scans tracked files for leaked secrets.
**Date:** 2026-02-12
**Refs:** CFG-005

## SEC-002: Project Secrets in .mise.local.toml

**Decision:** Per-project secrets use `.mise.local.toml` (gitignored by convention).
**Rationale:** mise supports local config files that override the global config. These are never committed and hold project-specific environment variables like database URLs, API keys, etc.
**Date:** 2026-02-12
**Refs:** CFG-005

## SEC-003: No Secrets in Tracked Files

**Decision:** Tracked files (`dot_*`, `dot_config/`, SoT/, `.claude/`) must NEVER contain secrets.
**Rationale:** The repository is synced across machines and may be publicly visible. Even private repos can be compromised. Defense in depth: keep secrets out of version control entirely.
**Patterns to block:** `API_KEY`, `SECRET_KEY`, `PRIVATE_KEY`, `PASSWORD=`, `TOKEN=`, `Bearer `, `sk-`, `ghp_`, `ghs_`
**Date:** 2026-02-12
**Refs:** SEC-001, SEC-002

## SEC-004: .gitignore as Security Layer

**Decision:** The `.gitignore` blocks `*.local`, `.env`, `.env.*`, `*.secret`, and `temp/` from being tracked.
**Rationale:** Defense in depth — even if a secret is accidentally placed in the repo directory, gitignore prevents it from being staged. The `dotfiles-sync-check` skill validates gitignore coverage.
**Date:** 2026-02-12
**Refs:** SEC-003
