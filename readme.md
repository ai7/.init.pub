# .init.pub

Portable dotfiles that work everywhere, with no company or site-specific dependencies.

## Structure

| Path | Description |
|------|-------------|
| `zsh/` | Zsh configuration — history, keybindings, path management, prompt, aliases |
| `mac/` | macOS-specific settings (Home/End key bindings) |
| `install.sh` | Symlinks config files into `$HOME` |

## Installation

Clone to `~/.init.pub` and run the install script:

```sh
cd ~
git clone https://github.com/ai7/.init.pub.git
.init.pub/install.sh
```

This creates symlinks (e.g. `~/.zshrc` → `.init.pub/zsh/zshrc`) so updates
pull through automatically.

## Design Principles

- No external dependencies — works on a fresh system
- Platform-aware — detects macOS/Linux/Windows and adapts
- Extensible — drop `zshrc_*` files (with execute permission) for site-specific additions
