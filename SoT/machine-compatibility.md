---
version: 0.1
last-updated: 2026-02-12
status: active
---

# Machine Compatibility

Cross-machine compatibility notes for the dotfiles configuration. Each entry uses the `COMPAT-` prefix.

---

## COMPAT-001: Target Machines

**Decision:** Dotfiles target Mac Studio and MacBook Pro, both running macOS.
**Rationale:** These are the two development machines in active use. All configuration must work on both without manual adjustment (aside from `.zshrc.local` for machine-specific values).
**Date:** 2026-02-12
**Refs:** CFG-001

## COMPAT-002: Homebrew on Apple Silicon

**Decision:** Homebrew prefix is `/opt/homebrew` (Apple Silicon default).
**Known issue:** `dot_zshrc` hardcodes `/opt/homebrew/bin` in PATH. `dot_fzf.zsh` checks for `/opt/homebrew/opt/fzf/bin`. If an Intel Mac is ever added, these paths would need to be conditionally set (Intel uses `/usr/local`).
**Mitigation:** Both current machines are Apple Silicon, so this works today. If an Intel machine is added, use chezmoi templating: `{{ if eq .chezmoi.arch "arm64" }}/opt/homebrew{{ else }}/usr/local{{ end }}`.
**Date:** 2026-02-12
**Refs:** TOOL-002

## COMPAT-003: Hard-Coded User Paths

**Known issue:** Several entries in `dot_zshrc` use hard-coded `/Users/mattgierhart/` paths:
- Bun completions: `/Users/mattgierhart/.bun/_bun`
- Docker completions: `/Users/mattgierhart/.docker/completions`
- Claude alias: `/Users/mattgierhart/.claude/local/claude`
- Antigravity: `/Users/mattgierhart/.antigravity/antigravity/bin`
- mise activation: `/Users/mattgierhart/.local/bin/mise`

**Impact:** These work if the username is `mattgierhart` on both machines. If the username ever differs, these would break.
**Recommended fix:** Replace with `$HOME`-based paths or use chezmoi templating.
**Date:** 2026-02-12
**Refs:** CFG-001

## COMPAT-004: Graceful Tool Fallback

**Decision:** Shell startup should not fail if a tool is missing.
**Current state:** Some integrations use conditional loading (e.g., `[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"`), which is correct. Others source unconditionally (e.g., `. "$HOME/.local/bin/env"`).
**Recommendation:** All tool integrations should use `command -v` or file-existence checks before sourcing/evaluating.
**Date:** 2026-02-12
**Refs:** CFG-003
