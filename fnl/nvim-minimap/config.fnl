(module nvim-minimap.config
  {autoload {nvim aniseed.nvim
             a aniseed.core
             string aniseed.string}})

(defonce- defaults
  {:default_auto_cmds_enabled 1
   :filetype {:excludes [:help
                         :qf]}
   :highlight {:group :MinimapCurrentLine}
   :window {:width 20
            :height 10}})

;; code from Olical/conjure
(defn- ks->name [ks]
  (.. "minimap#" (string.join "#" ks)))

(defn get-in [ks]
  "Get value from global."
  (let [v (a.get nvim.g (ks->name ks))]
    (if v
      (if (and (a.table? v)
               (a.get v vim.type_idx)
               (a.get v vim.val_idx))
        (a.get v vim.val_idx)
        v)
      (a.get-in defaults ks))))

(comment
  (->> (ks->name [:test])
       (a.get nvim.g))
  (get-in [:test])
  (get-in [:window :height])
  (get-in [:filetype :excludes]))
