(module nvim-minimap.main
  {autoload {nvim aniseed.nvim
             a aniseed.core
             float nvim-minimap.float
             config nvim-minimap.config
             minimap nvim-minimap.minimap}})

(defonce- state
  {:opened false})

(defn- viml->lua [name opts]
  (.. "lua require('" *module-name* "')['" name "']("
      (or (and opts opts.args) "") ")"))

(defn render [buf]
  (-> (minimap.minimap buf)
      (float.write-arr-to-buf)))

(defn refresh []
  (when state.opened
    (let [buf (vim.fn.bufnr :%)
          ft (. (. nvim.bo buf) :ft)
          excludes? (a.some
                      (fn [x]
                        (= x ft))
                      (config.get-in [:filetype :excludes]))]
      (when (not excludes?)
        (float.clear-buf)
        (render buf)))))

(defn open []
  (let [buf (vim.fn.bufnr :%)]
    (set state.opened true)
    (float.open-win)
    (render buf)))

(defn close []
  (set state.opened false)
  (float.close-win))

(defn- init-commands []
  (nvim.ex.command_ :MinimapOpen (viml->lua :open {}))
  (nvim.ex.command_ :MinimapClose (viml->lua :close {}))
  (nvim.ex.command_ :MinimapRefresh (viml->lua :refresh {})))

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
