local _0_0
do
  local name_0_ = "nvim-minimap.float"
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
    return {autoload("nvim-minimap.aniseed.core"), autoload("nvim-minimap.config"), autoload("nvim-minimap.aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {autoload = {a = "nvim-minimap.aniseed.core", config = "nvim-minimap.config", nvim = "nvim-minimap.aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local config = _local_0_[2]
local nvim = _local_0_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "nvim-minimap.float"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local state
do
  local v_0_ = (((_0_0)["aniseed/locals"]).state or {["buf-id"] = nil, ["win-id"] = nil})
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["state"] = v_0_
  state = v_0_
end
local editor_width
do
  local v_0_
  local function editor_width0()
    return nvim.o.columns
  end
  v_0_ = editor_width0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["editor-width"] = v_0_
  editor_width = v_0_
end
local editor_height
do
  local v_0_
  local function editor_height0()
    return nvim.o.lines
  end
  v_0_ = editor_height0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["editor-height"] = v_0_
  editor_height = v_0_
end
local make_buf
do
  local v_0_
  local function make_buf0()
    local buf = nvim.create_buf(false, true)
    state["buf-id"] = buf
    return buf
  end
  v_0_ = make_buf0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["make-buf"] = v_0_
  make_buf = v_0_
end
local make_win
do
  local v_0_
  local function make_win0(buf)
    local cur = nvim.get_current_win()
    local opts = {anchor = "NE", col = editor_width(), focusable = false, height = config["get-in"]({"window", "height"}), relative = "editor", row = 0, style = "minimal", width = config["get-in"]({"window", "width"})}
    local win = nvim.open_win(buf, 0, opts)
    nvim.win_set_option(win, "wrap", false)
    state["win-id"] = win
    nvim.set_current_win(cur)
    return win
  end
  v_0_ = make_win0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["make-win"] = v_0_
  make_win = v_0_
end
local open_win
do
  local v_0_
  do
    local v_0_0
    local function open_win0()
      if state["buf-id"] then
        if state["win-id"] then
          return state["win-id"]
        else
          return make_win(state["buf-id"])
        end
      else
        return make_win(make_buf())
      end
    end
    v_0_0 = open_win0
    _0_0["open-win"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["open-win"] = v_0_
  open_win = v_0_
end
local close_win
do
  local v_0_
  do
    local v_0_0
    local function close_win0()
      if state["win-id"] then
        pcall(nvim.win_close, state["win-id"], true)
        state["win-id"] = nil
        return nil
      end
    end
    v_0_0 = close_win0
    _0_0["close-win"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["close-win"] = v_0_
  close_win = v_0_
end
local write_arr_to_buf
do
  local v_0_
  do
    local v_0_0
    local function write_arr_to_buf0(arr)
      if state["buf-id"] then
        local trim_by_width
        local function _2_(x)
          return nvim.fn.strcharpart(x, 0, config["get-in"]({"window", "width"}))
        end
        trim_by_width = _2_
        return nvim.buf_set_lines(state["buf-id"], 0, -1, true, a.map(trim_by_width, arr))
      end
    end
    v_0_0 = write_arr_to_buf0
    _0_0["write-arr-to-buf"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["write-arr-to-buf"] = v_0_
  write_arr_to_buf = v_0_
end
local clear_highlights
do
  local v_0_
  local function clear_highlights0()
    if state["win-id"] then
      for i, h in ipairs(vim.fn.getmatches(state["win-id"])) do
        vim.fn.matchdelete(h.id, state["win-id"])
      end
      return nil
    end
  end
  v_0_ = clear_highlights0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["clear-highlights"] = v_0_
  clear_highlights = v_0_
end
local clear_buf
do
  local v_0_
  do
    local v_0_0
    local function clear_buf0()
      clear_highlights()
      return write_arr_to_buf({})
    end
    v_0_0 = clear_buf0
    _0_0["clear-buf"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["clear-buf"] = v_0_
  clear_buf = v_0_
end
local window_info
do
  local v_0_
  do
    local v_0_0
    local function window_info0()
      if state["win-id"] then
        return a.first(vim.fn.getwininfo(state["win-id"]))
      end
    end
    v_0_0 = window_info0
    _0_0["window-info"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["window-info"] = v_0_
  window_info = v_0_
end
local highlight_range
do
  local v_0_
  do
    local v_0_0
    local function highlight_range0(_2_0)
      local _arg_0_ = _2_0
      local bottom = _arg_0_["bottom"]
      local top = _arg_0_["top"]
      if state["win-id"] then
        local hlgroup = config["get-in"]({"highlight", "group"})
        for i = vim.fn.floor(top), vim.fn.ceil(bottom) do
          vim.fn.matchaddpos(hlgroup, {i}, 10, -1, {window = state["win-id"]})
        end
        return nil
      end
    end
    v_0_0 = highlight_range0
    _0_0["highlight-range"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["highlight-range"] = v_0_
  highlight_range = v_0_
end
-- (def buf (nvim.create_buf false true)) (def opts table: 0x7f8212c97f50) (nvim.open_win buf 0 opts) (make-buf-and-win) (open-win) (write-arr-to-buf table: 0x7f8212c99bd8) (write-arr-to-buf table: 0x7f8212b16960) (clear-buf) (close-win) (window-info)
return nil