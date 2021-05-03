nvim-minimap
===

Show minimap using Neovim floating window.

![demo](https://user-images.githubusercontent.com/1588935/116887327-26f1fe80-ac65-11eb-9ec0-d998956ab546.gif)

Fully written in [Fennel](https://fennel-lang.org/). Doesn't requires external libraries/commands.
This plugin is built using [Olical/aniseed](https://github.com/Olical/aniseed).

**Currently work in progress.**


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
- `g:minimap#highlight#group` - Default: `MinimapCurrentLine`. highlight group of current window range.
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


TODO
---

- [X] Scroll automatically
- [X] Highlight of current position
- [ ] Configurable scaling factor
- [ ] Improve performance using early break on loops
- [ ] Window position
- [ ] Automatically scale window
