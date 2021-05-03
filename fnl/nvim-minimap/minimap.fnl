(module nvim-minimap.minimap
  {autoload {nvim aniseed.nvim
             a aniseed.core
             string aniseed.string}})

;; this table is came from wfxr/code-minimap
(defonce- braille-table
  ["⠀" "⠁" "⠂" "⠃" "⠄" "⠅" "⠆" "⠇" "⡀" "⡁" "⡂" "⡃" "⡄" "⡅" "⡆" "⡇"
   "⠈" "⠉" "⠊" "⠋" "⠌" "⠍" "⠎" "⠏" "⡈" "⡉" "⡊" "⡋" "⡌" "⡍" "⡎" "⡏"
   "⠐" "⠑" "⠒" "⠓" "⠔" "⠕" "⠖" "⠗" "⡐" "⡑" "⡒" "⡓" "⡔" "⡕" "⡖" "⡗"
   "⠘" "⠙" "⠚" "⠛" "⠜" "⠝" "⠞" "⠟" "⡘" "⡙" "⡚" "⡛" "⡜" "⡝" "⡞" "⡟"
   "⠠" "⠡" "⠢" "⠣" "⠤" "⠥" "⠦" "⠧" "⡠" "⡡" "⡢" "⡣" "⡤" "⡥" "⡦" "⡧"
   "⠨" "⠩" "⠪" "⠫" "⠬" "⠭" "⠮" "⠯" "⡨" "⡩" "⡪" "⡫" "⡬" "⡭" "⡮" "⡯"
   "⠰" "⠱" "⠲" "⠳" "⠴" "⠵" "⠶" "⠷" "⡰" "⡱" "⡲" "⡳" "⡴" "⡵" "⡶" "⡷"
   "⠸" "⠹" "⠺" "⠻" "⠼" "⠽" "⠾" "⠿" "⡸" "⡹" "⡺" "⡻" "⡼" "⡽" "⡾" "⡿"
   "⢀" "⢁" "⢂" "⢃" "⢄" "⢅" "⢆" "⢇" "⣀" "⣁" "⣂" "⣃" "⣄" "⣅" "⣆" "⣇"
   "⢈" "⢉" "⢊" "⢋" "⢌" "⢍" "⢎" "⢏" "⣈" "⣉" "⣊" "⣋" "⣌" "⣍" "⣎" "⣏"
   "⢐" "⢑" "⢒" "⢓" "⢔" "⢕" "⢖" "⢗" "⣐" "⣑" "⣒" "⣓" "⣔" "⣕" "⣖" "⣗"
   "⢘" "⢙" "⢚" "⢛" "⢜" "⢝" "⢞" "⢟" "⣘" "⣙" "⣚" "⣛" "⣜" "⣝" "⣞" "⣟"
   "⢠" "⢡" "⢢" "⢣" "⢤" "⢥" "⢦" "⢧" "⣠" "⣡" "⣢" "⣣" "⣤" "⣥" "⣦" "⣧"
   "⢨" "⢩" "⢪" "⢫" "⢬" "⢭" "⢮" "⢯" "⣨" "⣩" "⣪" "⣫" "⣬" "⣭" "⣮" "⣯"
   "⢰" "⢱" "⢲" "⢳" "⢴" "⢵" "⢶" "⢷" "⣰" "⣱" "⣲" "⣳" "⣴" "⣵" "⣶" "⣷"
   "⢸" "⢹" "⢺" "⢻" "⢼" "⢽" "⢾" "⢿" "⣸" "⣹" "⣺" "⣻" "⣼" "⣽" "⣾" "⣿"])

(defn- braille-idx [x y]
  "returns an index to enable specified place (x, y) of braille.
  x: [0-1], y: [0-3]"
  (* (^ 2 y) (^ 16 x)))

(defn- ->braille [...]
  (->> [...]
       (a.reduce (fn [acc x]
                   (+ acc x)) 0)
       (a.inc)
       (. braille-table)))

(defn- get-buffer-lines [buf]
  (vim.fn.getbufline buf 1 :$))

(defn- lines->range-list [lines]
  (let [f (fn [l]
            (let [ll (length l)
                  t {:begin ll
                     :end 0}
                  idx-of (fn [l i]
                           (let [idx (a.inc i)]
                             (l:sub idx idx)))]
              (for [i 0 ll :until (< t.begin ll)]
                (when (not (string.blank? (idx-of l i)))
                  (set t.begin i)))
              (for [i ll 0 -1 :until (> t.end 1)]
                (when (not (string.blank? (idx-of l i)))
                  (set t.end i)))
              t))]
    (a.map f lines)))

(defn- scale [factor ls]
  (let [x-factor factor
        ; y-factor (* factor 4) ;; TODO: y-scale
        ->scale (fn [{: begin : end}]
                  {:begin (* begin x-factor)
                   :end (* end x-factor)})]
    (a.map ->scale ls)))

(defn- ->chunks [n ls]
  (let [t {:result []
           :tmp []
           :i 0}]
    (each [i l (ipairs ls)]
      (table.insert t.tmp l)
      (if (= t.i (a.dec n))
        (do
          (table.insert t.result t.tmp)
          (set t.tmp [])
          (set t.i 0))
        (set t.i (a.inc t.i))))
    (when (not (a.empty? t.tmp))
      (table.insert t.result t.tmp))
    t.result))

(defn- ->line [chunk]
  (var result "")
  (for [i 0 100 2] ; TODO: early break
    (var b-idx 0)
    (each [j v (ipairs chunk)]
      (let [{: begin : end} v
            di (a.dec i)
            dj (a.dec j)]
        (when (and (<= begin di)
                   (> end di))
          (set b-idx (+ b-idx (braille-idx 0 dj))))
        (when (and (<= begin i)
                   (> end i))
          (set b-idx (+ b-idx (braille-idx 1 dj))))
        ))
    (set result (.. result (->braille b-idx))))
  result)

(defn- ->minimap-lines [chunks]
  (a.map ->line chunks))

(defn minimap [buf]
  (->> (get-buffer-lines buf)
       (lines->range-list)
       (scale 0.25)
       (->chunks 4)
       (->minimap-lines)))

(comment
  (->braille (braille-idx 0 0))
  (->braille (braille-idx 0 0)
             (braille-idx 1 0)
             (braille-idx 0 2))

  (scale 0.25 [{:begin 0 :end 24}
               {:begin 19 :end 28}
               {:begin 19 :end 38}
               {:begin 2 :end 48}])

  (->chunks 4 [:a :b :c :d :e :f :g :h :i :j])

  (->line [{:begin 0 :end 24}
           {:begin 19 :end 28}
           {:begin 19 :end 38}
           {:begin 2 :end 48}])

  (minimap (vim.fn.bufnr :%)))
