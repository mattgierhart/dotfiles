# Matt's Dotfiles

Personal development environment configuration synced across Mac Studio and MacBook Pro.

## What's Included

- **mise** - Environment and tool version management
- **zsh** - Shell configuration with mise and fzf integration
- **fzf** - Fuzzy finder shell integration

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

## Security Note

API keys and secrets are NOT stored in this repo. They should be:
- Stored in `.mise.local.toml` per project (gitignored)
- Or in environment-specific shell configs (not synced)

## Files Managed

- `~/.config/mise/config.toml` - Global mise configuration
- `~/.zshrc` - Shell configuration (sans secrets)
- `~/.fzf.zsh` - Fuzzy finder integration
