# macOS Configuration

## DefaultKeyBinding.dict

Fixes Home/End keys to behave as beginning/end of line (like Windows/Linux)
instead of the macOS default of scrolling to the top/bottom of the document.

| Key | Action |
|-----|--------|
| Home | Move to beginning of line |
| End | Move to end of line |
| Shift+Home | Select to beginning of line |
| Shift+End | Select to end of line |

Installed via symlink: `~/Library/KeyBindings/DefaultKeyBinding.dict` → `~/.init.pub/mac/DefaultKeyBinding.dict`

Applies to all Cocoa-based apps (TextEdit, Safari, Notes, etc.) but not
terminal emulators or Electron apps which handle input directly.

Requires logout/login (or app restart) to take effect.
