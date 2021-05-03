(module nvim-minimap.float
  {autoload {nvim aniseed.nvim
             a aniseed.core
             config nvim-minimap.config}})

(defonce- state
  {:buf-id nil
   :win-id nil})

(defn- editor-width []
  nvim.o.columns)

(defn- editor-height []
  nvim.o.lines)

(defn- make-buf []
  (let [buf (nvim.create_buf false true)]
    (set state.buf-id buf)
    buf))

(defn- make-win [buf]
  (let [cur (nvim.get_current_win)
        opts {:relative :editor
              :width (config.get-in [:window :width])
              :height (config.get-in [:window :height])
              :col (editor-width)
              :row 0
              :anchor :NE
              :style :minimal
              :focusable false}
        win (nvim.open_win buf 0 opts)]
    (nvim.win_set_option win :wrap false)
    (set state.win-id win)
    (nvim.set_current_win cur)
    win))

(defn open-win []
  (if state.buf-id
    (if state.win-id
      state.win-id
      (make-win state.buf-id))
    (-> (make-buf)
        (make-win))))

(defn close-win []
  (when state.win-id
    (pcall nvim.win_close state.win-id true)
    (set state.win-id nil)))

(defn write-arr-to-buf [arr]
  (when state.buf-id
    (let [trim-by-width (fn [x]
                          (nvim.fn.strcharpart
                            x 0 (config.get-in [:window :width])))]
      (->> arr
           (a.map trim-by-width)
           (nvim.buf_set_lines
             state.buf-id
             0
             -1
             true)))))

(defn- clear-highlights []
  (when state.win-id
    (each [i h (ipairs (vim.fn.getmatches state.win-id))]
      (vim.fn.matchdelete h.id state.win-id))))

(defn clear-buf []
  (clear-highlights)
  (write-arr-to-buf []))

(defn window-info []
  (when state.win-id
    (a.first (vim.fn.getwininfo state.win-id))))

(defn highlight-range [{: top : bottom}]
  (when state.win-id
    (let [hlgroup (config.get-in [:highlight :group])]
      (for [i (vim.fn.floor top) (vim.fn.ceil bottom)]
        (vim.fn.matchaddpos hlgroup [i] 10 -1 {:window state.win-id})))))

(comment
  (def buf (nvim.create_buf false true))
  (def opts {:relative :editor
             :width 20
             :height (editor-height)
             :col (editor-width)
             :row 0
             :anchor :NE
             :style :minimal
             :focusable false})
  (nvim.open_win buf 0 opts)
  (make-buf-and-win)
  (open-win)
  (write-arr-to-buf [])
  (write-arr-to-buf ["test1" "test2"])
  (clear-buf)
  (close-win)
  (window-info))
