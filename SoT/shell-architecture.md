---
version: 0.1
last-updated: 2026-02-12
status: active
---

# Shell Architecture

Documents the shell startup flow, integration points, and sourcing order. This file serves as the deployment/runtime specification for the dotfiles.

---

## Startup Flow

The `dot_zshrc` file is sourced by zsh on interactive shell startup. It follows this order:

```
1. NVM setup             → $NVM_DIR/nvm.sh + bash_completion
2. Bun setup             → completions + PATH ($BUN_INSTALL/bin)
3. Local env             → $HOME/.local/bin/env
4. Docker completions    → fpath addition + compinit
5. Homebrew PATH         → /opt/homebrew/bin
6. Claude CLI alias      → alias claude=...
7. Antigravity PATH      → $HOME/.antigravity/.../bin
8. mise activation       → eval "$(mise activate zsh)"
9. fzf integration       → source ~/.fzf.zsh (which adds fzf to PATH + shell integration)
10. Local secrets        → source ~/.zshrc.local (if exists)
```

### Design Principles

- **Secrets last**: `.zshrc.local` is sourced at the end so it can override any earlier setting.
- **Heavy tools early**: NVM and Bun load first since they modify PATH and need to be available for downstream tools.
- **Completions grouped**: Docker completions and `compinit` are called together.
- **mise after PATH setup**: mise activation happens after Homebrew is on PATH, since mise itself may be installed via Homebrew.
- **fzf as integration layer**: fzf is a separate file (`dot_fzf.zsh`) to keep its setup isolated.

## Auxiliary Files

### dot_fzf.zsh

Dedicated fzf configuration:
1. Adds `/opt/homebrew/opt/fzf/bin` to PATH (if not already present)
2. Loads fzf shell integration via `fzf --zsh`

### dot_config/mise/private_config.toml

Global mise configuration:
- **Tools**: `node = "lts"` — manages Node.js LTS version
- **Env**: `EDITOR = "code"` — sets VS Code as default editor
- **Settings**: `experimental = true` — enables mise experimental features

## Environment Variables

Key environment variables set during startup:

| Variable | Source | Value |
|----------|--------|-------|
| `NVM_DIR` | dot_zshrc | `$HOME/.nvm` |
| `BUN_INSTALL` | dot_zshrc | `$HOME/.bun` |
| `PATH` | multiple | Includes: `$BUN_INSTALL/bin`, `/opt/homebrew/bin`, Antigravity bin, fzf bin |
| `EDITOR` | mise config | `code` |

## Integration Points

| Tool | Integration Type | Mechanism |
|------|-----------------|-----------|
| NVM | Source script | `\. "$NVM_DIR/nvm.sh"` |
| Bun | Source completions + PATH | `source .bun/_bun` + PATH prepend |
| Docker | Completions | fpath addition + `compinit` |
| mise | Eval activation | `eval "$(mise activate zsh)"` |
| fzf | Dedicated file | `source ~/.fzf.zsh` → PATH + shell integration |
| Claude | Alias | `alias claude=...` |

## Known Considerations

- **Startup performance**: Multiple tools are sourced synchronously. NVM is particularly slow. Consider lazy-loading or replacing with mise-only (see CFG-003).
- **compinit called once**: `compinit` should ideally be called once after all fpath modifications. Currently called after Docker completions but before fzf loads.
- **PATH ordering**: Later PATH additions take precedence. Homebrew's `/opt/homebrew/bin` is added after Bun, meaning system tools take precedence over Bun equivalents.
