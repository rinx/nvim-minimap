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
local state
do
  local v_0_ = (((_0_0)["aniseed/locals"]).state or {["running-timer"] = nil, opened = false})
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["state"] = v_0_
  state = v_0_
end
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
local calc_display_range
do
  local v_0_
  local function calc_display_range0(scale_factor)
    local minimap_window = float["window-info"]()
    local display_lines = (minimap_window.height / scale_factor)
    local total = vim.fn.line("$")
    local cur_win_top = vim.fn.line("w0")
    local cur_win_bottom = vim.fn.line("w$")
    local cur_win_lines = (cur_win_bottom - cur_win_top)
    if (cur_win_lines > display_lines) then
      return {bottom = (cur_win_top + display_lines), top = cur_win_top}
    else
      local hrest = ((display_lines - cur_win_lines) / 2)
      local top_canditate = (cur_win_top - vim.fn.floor(hrest))
      local bottom_canditate = (cur_win_bottom + vim.fn.ceil(hrest))
      if (top_canditate > 0) then
        if (bottom_canditate <= total) then
          return {bottom = bottom_canditate, top = top_canditate}
        else
          return {bottom = "$", top = top_canditate}
        end
      else
        if (display_lines <= total) then
          return {bottom = a.inc(display_lines), top = 1}
        else
          return {bottom = "$", top = 1}
        end
      end
    end
  end
  v_0_ = calc_display_range0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["calc-display-range"] = v_0_
  calc_display_range = v_0_
end
local render
do
  local v_0_
  local function render0(buf)
    local scale_factor = 0.25
    local range = calc_display_range(scale_factor)
    return float["write-arr-to-buf"](minimap.minimap(buf, {["scale-factor"] = scale_factor, bottom = range.bottom, top = range.top}))
  end
  v_0_ = render0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["render"] = v_0_
  render = v_0_
end
local stop_timer
do
  local v_0_
  local function stop_timer0(timer)
    if not timer:is_closing() then
      timer:stop()
      return timer:close()
    end
  end
  v_0_ = stop_timer0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["stop-timer"] = v_0_
  stop_timer = v_0_
end
local refresh
do
  local v_0_
  do
    local v_0_0
    local function refresh0()
      if state.opened then
        local buf = vim.fn.bufnr("%")
        local ft = nvim.bo[buf].ft
        local excludes_3f
        local function _2_(x)
          return (x == ft)
        end
        excludes_3f = a.some(_2_, config["get-in"]({"filetype", "excludes"}))
        if not excludes_3f then
          if state["running-timer"] then
            stop_timer(state["running-timer"])
            state["running-timer"] = nil
          end
          local timer = vim.loop.new_timer()
          local function _4_()
            float["clear-buf"]()
            render(buf)
            return stop_timer(timer)
          end
          timer:start(20, 0, vim.schedule_wrap(_4_))
          state["running-timer"] = timer
          return nil
        end
      end
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
      state.opened = true
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
      state.opened = false
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
local toggle
do
  local v_0_
  do
    local v_0_0
    local function toggle0()
      if state.opened then
        return close()
      else
        return open()
      end
    end
    v_0_0 = toggle0
    _0_0["toggle"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["toggle"] = v_0_
  toggle = v_0_
end
local init_commands
do
  local v_0_
  local function init_commands0()
    nvim.ex.command_("MinimapOpen", viml__3elua("open", {}))
    nvim.ex.command_("MinimapClose", viml__3elua("close", {}))
    nvim.ex.command_("MinimapToggle", viml__3elua("toggle", {}))
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
-- (open) (close) (toggle) (render (vim.fn.bufnr %)) (refresh)
return nil