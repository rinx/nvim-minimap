nvim-minimap
===

Show minimap using Neovim floating window.

![demo](https://user-images.githubusercontent.com/1588935/116861327-e59a2880-ac3d-11eb-9eae-e6c6476685be.gif)

Fully written in Fennel (a Lisp dialects that compiled to Lua script). Doesn't requires external libraries/commands.

**Currently work in progress. Limited number of features are available.**


Installation
---

Requires Neovim 0.5+.

### packer.nvim

```lua
use 'rinx/nvim-minimap'
```


### vim-plug

```
Plug 'rinx/nvim-minimap'
```

Commands
---

- `:MinimapOpen` - show minimap window
- `:MinimapClose` - close minimap window
- `:MinimapToggle` - toggle
- `:MinimapRefresh` - refresh minimap window


Configurations
---

- `g:minimap#default_auto_cmds_enabled` - Default `1`. If it is `1`, autocmds are registered when the plugin is loaded.
- `g:minimap#filetype#excludes` - Default: `['help', 'qf']`. Minimap will not be shown for these filetypes.
- `g:minimap#window#width` - Default: `20`. The width of floating window.
- `g:minimap#window#height` - Default: `10`. The height of floating window.


License
---

MIT


Similar Projects
---

- [wfxr/minimap.vim](https://github.com/wfxr/minimap.vim)
    - [wfxr/code-minimap](https://github.com/wfxr/code-minimap)
- [Xuyuanp/scrollbar.nvim](https://github.com/Xuyuanp/scrollbar.nvim)
- [severin-lemaignan/vim-minimap](https://github.com/severin-lemaignan/vim-minimap)

This plugin is built using [Olical/aniseed](https://github.com/Olical/aniseed).

TODO
---

- [X] Scroll automatically
- [ ] Highlight of current position
- [ ] Configurable scaling factor
- [ ] Improve performance using early break on loops
