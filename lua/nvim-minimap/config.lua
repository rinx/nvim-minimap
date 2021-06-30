local _2afile_2a = "fnl/nvim-minimap/config.fnl"
local _0_
do
  local name_0_ = "nvim-minimap.config"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  do end (module_0_)["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  do end (package.loaded)[name_0_] = module_0_
  _0_ = module_0_
end
local autoload
local function _1_(...)
  return (require("nvim-minimap.aniseed.autoload")).autoload(...)
end
autoload = _1_
local function _2_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _2_()
    return {autoload("nvim-minimap.aniseed.core"), autoload("nvim-minimap.aniseed.nvim"), autoload("nvim-minimap.aniseed.string")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {a = "nvim-minimap.aniseed.core", nvim = "nvim-minimap.aniseed.nvim", string = "nvim-minimap.aniseed.string"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local a = _local_0_[1]
local nvim = _local_0_[2]
local string = _local_0_[3]
local _2amodule_2a = _0_
local _2amodule_name_2a = "nvim-minimap.config"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
local defaults
do
  local v_0_ = ((_0_)["aniseed/locals"].defaults or {default_auto_cmds_enabled = 1, filetype = {excludes = {"help", "qf"}}, highlight = {group = "MinimapCurrentLine"}, window = {height = 10, width = 20}})
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["defaults"] = v_0_
  defaults = v_0_
end
local ks__3ename
do
  local v_0_
  local function ks__3ename0(ks)
    return ("minimap#" .. string.join("#", ks))
  end
  v_0_ = ks__3ename0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["ks->name"] = v_0_
  ks__3ename = v_0_
end
local get_in
do
  local v_0_
  do
    local v_0_0
    local function get_in0(ks)
      local v = a.get(nvim.g, ks__3ename(ks))
      if v then
        if (a["table?"](v) and a.get(v, vim.type_idx) and a.get(v, vim.val_idx)) then
          return a.get(v, vim.val_idx)
        else
          return v
        end
      else
        return a["get-in"](defaults, ks)
      end
    end
    v_0_0 = get_in0
    _0_["get-in"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["get-in"] = v_0_
  get_in = v_0_
end
-- (->> (ks->name table: 0x7fbc06198868) (a.get nvim.g)) (get-in table: 0x7fbc06150af0) (get-in table: 0x7fbc06118488) (get-in table: 0x7fbc05ec5f90)
return nil