# ZSH Configuration

Portable zsh settings designed to work everywhere without platform-specific dependencies.

## History

Aggressive dedup and noise reduction so history stays useful over time:

- Appends on exit (no cross-session clobbering)
- Deduplicates: ignores all dups, expires dups first at limit, never writes dups to file
- Ignores commands starting with a space (for sensitive commands)
- Auto-ignores throwaway commands (ls, cd, clear, exit, etc.) via `HISTORY_IGNORE`
- Large history: 16K in-memory, 64K saved to file

## Keybindings

- **Up/Down arrow** — search history by what you've already typed (not just prev/next)
- **Home/End/Delete** — work correctly across terminal types (xterm and vt220)

## Path Management

Helper functions to build `$PATH` without duplicates or missing-directory noise:

- `path_add <dir>` — append to path if the directory exists
- `path_prepend <dir>` — prepend to path if the directory exists
- `typeset -aU path` — zsh-native dedup, so repeated sourcing never bloats `$PATH`

Order of additions: system dirs first, then user dirs (`~/bin`, `~/.local/bin`)
at the end, with macOS package managers (Homebrew, then MacPorts) prepended so
they take priority.

## Other Setup

- **OS detection** — sets `$is_mac`, `$is_linux`, `$is_win` flags used by aliases and conditionals
- **Early exit for dumb shells** — skips full init for scp, rsync, emacs, vim subshells
- **Directory stack** — `AUTO_PUSHD` on every cd, so `cd -2`, `popd`, etc. just work
- **Smart-case completion** — typing lowercase matches uppercase (but not vice versa)
- **Noclobber** — `set -C` prevents accidental redirect overwrites (use `>|` to force)
- **Site extensions** — auto-sources any `zshrc_*` files with execute permission for local additions

- **Prompt** — loads `clint` by default (a multi-line prompt bundled with zsh).
  A custom `ray` theme is also available via `prompt ray` — it shows history number,
  exit status, tty/shell-level, user@host, and a smart-truncated path that collapses
  middle segments when the path is long (e.g. `~/a/b/c/d/e/f/g` → `~/a/..5../f/g`)

## Aliases (`zsh_alias`)

**Essential commands** — platform-aware defaults for `ls`, `ps`, `df` (Linux vs macOS flags).

**DOS habits** — `dir`, `cls`, `del`, `md`, `rd`, `copy`, `move` for muscle memory.

**Safety overrides** — `cp -ip`, `rm -i`, `mv -i` to prevent accidental destruction.

**Tool defaults** — `grep` with color/case-insensitive/extended-regex,
  `less` with smart-case, `diff` in unified format.

**Rsync suite** — pre-built commands for common workflows:
| Alias | Purpose |
|-------|---------|
| `rsync-backup` | one-way copy (won't delete at destination) |
| `rsync-diff` | dry-run showing what would transfer |
| `rsync-diff-mirror` | dry-run including deletions |
| `rsync-verify` | checksum-based comparison |
