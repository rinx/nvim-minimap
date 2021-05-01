(module nvim-minimap.main
  {autoload {nvim aniseed.nvim
             a aniseed.core
             float nvim-minimap.float
             config nvim-minimap.config
             minimap nvim-minimap.minimap}})

(defn- viml->lua [name opts]
  (.. "lua require('" *module-name* "')['" name "']("
      (or (and opts opts.args) "") ")"))

(defn render [buf]
  (-> (minimap.minimap buf)
      (float.write-arr-to-buf)))

(defn refresh []
  (let [buf (vim.fn.bufnr :%)]
    (float.clear-buf)
    (render buf)))

(defn open []
  (let [buf (vim.fn.bufnr :%)]
    (float.open-win)
    (render buf)))

(defn close []
  (float.close-win))

(defn- init-commands []
  (nvim.ex.command_ :MinimapOpen (viml->lua :open {}))
  (nvim.ex.command_ :MinimapClose (viml->lua :close {})))

(defn- init-autocmds []
  (nvim.ex.augroup :MinimapAutocmds)
  (nvim.ex.autocmd_)
  (nvim.ex.autocmd
    "WinEnter,BufEnter,FocusGained,CursorMoved,CursorMovedI,VimResized,QuitPre" "*"
    (.. "silent! " (viml->lua :refresh {})))
  (nvim.ex.augroup :END)
  )

(defn init []
  (init-commands)
  (when (= (config.get-in [:default_auto_cmds_enabled]) 1)
    (init-autocmds)))

(comment
  (open)
  (close)
  (render (vim.fn.bufnr :%))
  (refresh))
