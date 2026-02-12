---
version: 0.1
last-updated: 2026-02-12
status: active
---

# Tool Inventory

Registry of all tools managed through dotfiles. Each entry uses the `TOOL-` prefix.

---

## TOOL-001: mise

**Category:** Version management
**Installation:** Homebrew / curl installer
**Integration:** `eval "$(mise activate zsh)"` in `dot_zshrc`
**Managed versions:** Node LTS (via `dot_config/mise/private_config.toml`)
**Why:** Universal version manager — replaces nvm, pyenv, rbenv with a single tool. See CFG-002.
**Refs:** CFG-002, CFG-003

## TOOL-002: fzf

**Category:** Shell utility
**Installation:** Homebrew (`brew install fzf`)
**Integration:** Dedicated `dot_fzf.zsh` file sourced from `dot_zshrc`; adds `/opt/homebrew/opt/fzf/bin` to PATH and loads shell integration via `fzf --zsh`
**Why:** Fuzzy finder for files, command history, and shell completion. Significant productivity improvement for terminal workflows.
**Refs:** COMPAT-002

## TOOL-003: jq

**Category:** Data processing
**Installation:** Homebrew (`brew install jq`)
**Integration:** Available on PATH (no shell integration needed)
**Why:** JSON processing in shell scripts and pipelines. Also used by Claude Code hooks for parsing stdin JSON.

## TOOL-004: ripgrep (rg)

**Category:** Search utility
**Installation:** Homebrew (`brew install ripgrep`)
**Integration:** Available on PATH
**Why:** Fast recursive grep replacement. Respects `.gitignore`, faster than `grep -r`.

## TOOL-005: NVM (Node Version Manager)

**Category:** Version management (legacy)
**Installation:** curl installer to `$HOME/.nvm`
**Integration:** Sourced in `dot_zshrc` via `NVM_DIR` + lazy-load pattern
**Why:** Legacy version manager kept for backward compatibility during mise transition. See CFG-003.
**Refs:** CFG-003, TOOL-001

## TOOL-006: Bun

**Category:** JavaScript runtime
**Installation:** curl installer to `$HOME/.bun`
**Integration:** Completions sourced and `$BUN_INSTALL/bin` added to PATH in `dot_zshrc`
**Why:** Fast JavaScript/TypeScript runtime and package manager. Complements Node.js for specific use cases.

## TOOL-007: bat

**Category:** Shell utility
**Installation:** Homebrew (`brew install bat`)
**Integration:** Available on PATH
**Why:** Syntax-highlighted `cat` replacement. Improves readability of file contents in terminal.

## TOOL-008: httpie

**Category:** HTTP client
**Installation:** Homebrew (`brew install httpie`)
**Integration:** Available on PATH
**Why:** User-friendly HTTP client for API testing. More readable output than curl for development workflows.

## TOOL-009: Claude CLI

**Category:** AI assistant
**Installation:** Local binary at `~/.claude/local/claude`
**Integration:** Alias in `dot_zshrc`: `alias claude="~/.claude/local/claude"`
**Why:** Claude Code CLI for AI-assisted development.

## TOOL-010: Docker

**Category:** Containerization
**Installation:** Docker Desktop
**Integration:** CLI completions added to `fpath` in `dot_zshrc`, `compinit` called for completion loading
**Why:** Container runtime for development and deployment workflows.

## TOOL-011: Antigravity

**Category:** Development utility
**Installation:** Local binary at `~/.antigravity/antigravity/bin`
**Integration:** Added to PATH in `dot_zshrc`
**Why:** Development utility in the PATH.
