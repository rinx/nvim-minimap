local _0_0
do
  local name_0_ = "nvim-minimap.aniseed.eval"
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
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local autoload = (require("nvim-minimap.aniseed.autoload")).autoload
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {autoload("nvim-minimap.aniseed.core"), autoload("nvim-minimap.aniseed.compile"), autoload("nvim-minimap.aniseed.fennel"), autoload("nvim-minimap.aniseed.fs"), autoload("nvim-minimap.aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {autoload = {a = "nvim-minimap.aniseed.core", compile = "nvim-minimap.aniseed.compile", fennel = "nvim-minimap.aniseed.fennel", fs = "nvim-minimap.aniseed.fs", nvim = "nvim-minimap.aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local compile = _local_0_[2]
local fennel = _local_0_[3]
local fs = _local_0_[4]
local nvim = _local_0_[5]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "nvim-minimap.aniseed.eval"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local str
do
  local v_0_
  do
    local v_0_0
    local function str0(code, opts)
      local function _2_()
        return fennel.eval(compile["macros-prefix"](code), a.merge({["compiler-env"] = _G}, opts))
      end
      return xpcall(_2_, fennel.traceback)
    end
    v_0_0 = str0
    _0_0["str"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["str"] = v_0_
  str = v_0_
end
return nil
