local _0_0
do
  local name_0_ = "nvim-minimap.main"
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
    return {autoload("nvim-minimap.aniseed.core"), autoload("nvim-minimap.config"), autoload("nvim-minimap.float"), autoload("nvim-minimap.minimap"), autoload("nvim-minimap.aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {autoload = {a = "nvim-minimap.aniseed.core", config = "nvim-minimap.config", float = "nvim-minimap.float", minimap = "nvim-minimap.minimap", nvim = "nvim-minimap.aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local config = _local_0_[2]
local float = _local_0_[3]
local minimap = _local_0_[4]
local nvim = _local_0_[5]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "nvim-minimap.main"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local viml__3elua
do
  local v_0_
  local function viml__3elua0(name, opts)
    return ("lua require('" .. _2amodule_name_2a .. "')['" .. name .. "'](" .. ((opts and opts.args) or "") .. ")")
  end
  v_0_ = viml__3elua0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["viml->lua"] = v_0_
  viml__3elua = v_0_
end
local render
do
  local v_0_
  do
    local v_0_0
    local function render0(buf)
      return float["write-arr-to-buf"](minimap.minimap(buf))
    end
    v_0_0 = render0
    _0_0["render"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["render"] = v_0_
  render = v_0_
end
local refresh
do
  local v_0_
  do
    local v_0_0
    local function refresh0()
      local buf = vim.fn.bufnr("%")
      float["clear-buf"]()
      return render(buf)
    end
    v_0_0 = refresh0
    _0_0["refresh"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["refresh"] = v_0_
  refresh = v_0_
end
local open
do
  local v_0_
  do
    local v_0_0
    local function open0()
      local buf = vim.fn.bufnr("%")
      float["open-win"]()
      return render(buf)
    end
    v_0_0 = open0
    _0_0["open"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["open"] = v_0_
  open = v_0_
end
local close
do
  local v_0_
  do
    local v_0_0
    local function close0()
      return float["close-win"]()
    end
    v_0_0 = close0
    _0_0["close"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["close"] = v_0_
  close = v_0_
end
local init_commands
do
  local v_0_
  local function init_commands0()
    nvim.ex.command_("MinimapOpen", viml__3elua("open", {}))
    nvim.ex.command_("MinimapClose", viml__3elua("close", {}))
    return nvim.ex.command_("MinimapRefresh", viml__3elua("refresh", {}))
  end
  v_0_ = init_commands0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["init-commands"] = v_0_
  init_commands = v_0_
end
local init_autocmds
do
  local v_0_
  local function init_autocmds0()
    nvim.ex.augroup("MinimapAutocmds")
    nvim.ex.autocmd_()
    nvim.ex.autocmd("WinEnter,BufEnter,FocusGained,CursorMoved,CursorMovedI,VimResized,QuitPre", "*", ("silent! " .. viml__3elua("refresh", {})))
    return nvim.ex.augroup("END")
  end
  v_0_ = init_autocmds0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["init-autocmds"] = v_0_
  init_autocmds = v_0_
end
local init
do
  local v_0_
  do
    local v_0_0
    local function init0()
      init_commands()
      if (config["get-in"]({"default_auto_cmds_enabled"}) == 1) then
        return init_autocmds()
      end
    end
    v_0_0 = init0
    _0_0["init"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["init"] = v_0_
  init = v_0_
end
-- (open) (close) (render (vim.fn.bufnr %)) (refresh)
return nil