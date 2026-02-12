# Matt's Dotfiles

Personal development environment configuration synced across Mac Studio and MacBook Pro.

<!-- SECTION: status-header -->
**Machines:** Mac Studio, MacBook Pro | **Manager:** chezmoi | **Shell:** zsh | **Methodology:** [PRD-Led Context Engineering](https://github.com/mattgierhart/PRD-driven-context-engineering)
<!-- /SECTION: status-header -->

---

## What's Included

| Tool | Purpose | Integration |
|------|---------|-------------|
| **[mise](https://mise.jdx.dev/)** | Environment and tool version management | `eval` activation in zshrc |
| **zsh** | Shell configuration with tool integrations | `dot_zshrc` |
| **[fzf](https://github.com/junegunn/fzf)** | Fuzzy finder for files and history | Dedicated `dot_fzf.zsh` |
| **[jq](https://jqlang.github.io/jq/)** | JSON processing | PATH (Homebrew) |
| **[ripgrep](https://github.com/BurntSushi/ripgrep)** | Fast recursive search | PATH (Homebrew) |
| **[bat](https://github.com/sharkdp/bat)** | Syntax-highlighted cat | PATH (Homebrew) |
| **[httpie](https://httpie.io/)** | User-friendly HTTP client | PATH (Homebrew) |
| **[Bun](https://bun.sh/)** | JavaScript/TypeScript runtime | Completions + PATH |
| **NVM** | Node.js version manager (legacy) | Source script |
| **Docker** | Containerization | CLI completions |
| **Claude CLI** | AI-assisted development | Alias |

## Quick Setup

### New Machine

```bash
# Install via chezmoi (pulls and applies config)
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mattgierhart

# Install required tools
brew install jq yq httpie ripgrep fzf bat

# Activate mise
mise install
```

### Sync Changes

```bash
# After modifying configs on any machine
chezmoi update
```

## Repository Structure

```text
/
├── README.md                       # This file — dashboard and status
├── CLAUDE.md                       # Agent operating instructions
├── .gitignore                      # Excludes secrets, temp, editor files
│
├── dot_zshrc                       # Shell configuration (chezmoi-managed)
├── dot_fzf.zsh                     # Fuzzy finder integration
├── dot_config/
│   └── mise/
│       └── private_config.toml     # Global mise configuration
│
├── SoT/                            # Source of Truth — durable decisions
│   ├── config-decisions.md         # CFG- entries
│   ├── tool-inventory.md           # TOOL- entries
│   ├── security-model.md           # SEC- entries
│   ├── machine-compatibility.md    # COMPAT- entries
│   └── shell-architecture.md       # Shell startup flow and integrations
│
├── epics/                          # Working memory — multi-step changes
│   └── EPIC_TEMPLATE.md            # Template for new epics
│
├── temp/                           # Scratchpad (gitignored)
│
└── .claude/                        # Claude Code project configuration
    ├── settings.json               # Hook registration and permissions
    ├── README.md                   # .claude/ directory documentation
    ├── hooks/                      # Lifecycle automation (5 hooks)
    └── skills/                     # Workflow guidance (8 skills)
```

## Security Note

API keys and secrets are NOT stored in this repo. They should be:
- Stored in `~/.zshrc.local` per machine (not synced)
- Or in `.mise.local.toml` per project (gitignored)
- See `SoT/security-model.md` for the full security policy

## Files Managed

| Target Path | Source | Purpose |
|-------------|--------|---------|
| `~/.config/mise/config.toml` | `dot_config/mise/private_config.toml` | Global mise configuration |
| `~/.zshrc` | `dot_zshrc` | Shell configuration (sans secrets) |
| `~/.fzf.zsh` | `dot_fzf.zsh` | Fuzzy finder integration |

## Claude Code Integration

This repo uses the [PRD-Led Context Engineering](https://github.com/mattgierhart/PRD-driven-context-engineering) methodology for AI-assisted configuration management:

- **`.claude/`** — Project-level Claude Code configuration with hooks and skills
- **`CLAUDE.md`** — Agent operating instructions (session protocols, ID scheme, rules)
- **`SoT/`** — Source of Truth documents tracking configuration decisions with unique IDs
- **`epics/`** — Working memory for multi-step configuration changes

See `.claude/README.md` for full documentation of the Claude Code integration.
