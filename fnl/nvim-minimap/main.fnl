(module nvim-minimap.main
  {autoload {nvim aniseed.nvim
             a aniseed.core
             float nvim-minimap.float
             config nvim-minimap.config
             minimap nvim-minimap.minimap}})

(defonce- state
  {:opened false
   :running-timer nil})

(defn- viml->lua [name opts]
  (.. "lua require('" *module-name* "')['" name "']("
      (or (and opts opts.args) "") ")"))

(defn- calc-display-range [scale-factor]
  (let [minimap-window (float.window-info)
        display-lines (/ minimap-window.height scale-factor)
        total (vim.fn.line :$)
        cur-win-top (vim.fn.line :w0)
        cur-win-bottom (vim.fn.line :w$)
        cur-win-lines (- cur-win-bottom cur-win-top)]
    (if (> cur-win-lines display-lines)
      {:top cur-win-top
       :bottom (+ cur-win-top display-lines)
       :current {:top 1
                 :bottom minimap-window.height}}
      (let [hrest (/ (- display-lines cur-win-lines) 2)
            top-canditate (- cur-win-top (vim.fn.floor hrest))
            bottom-canditate (+ cur-win-bottom (vim.fn.ceil hrest))]
        (if (> top-canditate 0)
          (if (<= bottom-canditate total)
            {:top top-canditate
             :bottom bottom-canditate
             :current {:top (* hrest scale-factor)
                       :bottom (- minimap-window.height
                                  (* hrest scale-factor))}}
            {:top top-canditate
             :bottom :$
             :current {:top (* hrest scale-factor)
                       :bottom (* (+ hrest cur-win-lines) scale-factor)}})
          (if (<= display-lines total)
            {:top 1
             :bottom (a.inc display-lines)
             :current {:top (* cur-win-top scale-factor)
                       :bottom (* cur-win-bottom scale-factor)}}
            {:top 1
             :bottom :$
             :current {:top 1
                       :bottom minimap-window.height}}))))))

(defn- render [buf]
  (let [scale-factor 0.25
        range (calc-display-range scale-factor)]
    (-> (minimap.minimap buf {:top range.top
                              :bottom range.bottom
                              :scale-factor scale-factor})
        (float.write-arr-to-buf))
    (float.highlight-range range.current)))

(defn- stop-timer [timer]
  (when (not (timer:is_closing))
    (timer:stop)
    (timer:close)))

(defn refresh []
  (when state.opened
    (let [buf (vim.fn.bufnr :%)
          ft (. (. nvim.bo buf) :ft)
          excludes? (a.some
                      (fn [x]
                        (= x ft))
                      (config.get-in [:filetype :excludes]))]
      (when (not excludes?)
        (when state.running-timer
          (stop-timer state.running-timer)
          (set state.running-timer nil))
        (let [timer (vim.loop.new_timer)]
          (timer:start
            20
            0
            (vim.schedule_wrap
              (fn []
                (float.clear-buf)
                (render buf)
                (stop-timer timer))))
          (set state.running-timer timer))))))

(defn open []
  (let [buf (vim.fn.bufnr :%)]
    (set state.opened true)
    (float.open-win)
    (render buf)))

(defn close []
  (set state.opened false)
  (float.close-win))

(defn toggle []
  (if state.opened
    (close)
    (open)))

(defn- init-commands []
  (nvim.ex.command_ :MinimapOpen (viml->lua :open {}))
  (nvim.ex.command_ :MinimapClose (viml->lua :close {}))
  (nvim.ex.command_ :MinimapToggle (viml->lua :toggle {}))
  (nvim.ex.command_ :MinimapRefresh (viml->lua :refresh {})))

(defn- init-autocmds []
  (nvim.ex.augroup :MinimapAutocmds)
  (nvim.ex.autocmd_)
  (nvim.ex.autocmd
    "WinEnter,BufEnter,FocusGained,CursorMoved,CursorMovedI,VimResized,QuitPre" "*"
    (.. "silent! " (viml->lua :refresh {})))
  (nvim.ex.augroup :END))

(defn- define-highlights []
  (nvim.ex.highlight "MinimapCurrentLine ctermfg=green guifg=green"))

(defn init []
  (init-commands)
  (define-highlights)
  (when (= (config.get-in [:default_auto_cmds_enabled]) 1)
    (init-autocmds)))

(comment
  (open)
  (close)
  (toggle)
  (render (vim.fn.bufnr :%))
  (refresh))
