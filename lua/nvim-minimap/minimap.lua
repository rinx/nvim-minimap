local _0_0
do
  local name_0_ = "nvim-minimap.minimap"
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
    return {autoload("nvim-minimap.aniseed.core"), autoload("nvim-minimap.aniseed.nvim"), autoload("nvim-minimap.aniseed.string")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {autoload = {a = "nvim-minimap.aniseed.core", nvim = "nvim-minimap.aniseed.nvim", string = "nvim-minimap.aniseed.string"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local nvim = _local_0_[2]
local string = _local_0_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "nvim-minimap.minimap"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local braille_table
do
  local v_0_ = (((_0_0)["aniseed/locals"])["braille-table"] or {"\226\160\128", "\226\160\129", "\226\160\130", "\226\160\131", "\226\160\132", "\226\160\133", "\226\160\134", "\226\160\135", "\226\161\128", "\226\161\129", "\226\161\130", "\226\161\131", "\226\161\132", "\226\161\133", "\226\161\134", "\226\161\135", "\226\160\136", "\226\160\137", "\226\160\138", "\226\160\139", "\226\160\140", "\226\160\141", "\226\160\142", "\226\160\143", "\226\161\136", "\226\161\137", "\226\161\138", "\226\161\139", "\226\161\140", "\226\161\141", "\226\161\142", "\226\161\143", "\226\160\144", "\226\160\145", "\226\160\146", "\226\160\147", "\226\160\148", "\226\160\149", "\226\160\150", "\226\160\151", "\226\161\144", "\226\161\145", "\226\161\146", "\226\161\147", "\226\161\148", "\226\161\149", "\226\161\150", "\226\161\151", "\226\160\152", "\226\160\153", "\226\160\154", "\226\160\155", "\226\160\156", "\226\160\157", "\226\160\158", "\226\160\159", "\226\161\152", "\226\161\153", "\226\161\154", "\226\161\155", "\226\161\156", "\226\161\157", "\226\161\158", "\226\161\159", "\226\160\160", "\226\160\161", "\226\160\162", "\226\160\163", "\226\160\164", "\226\160\165", "\226\160\166", "\226\160\167", "\226\161\160", "\226\161\161", "\226\161\162", "\226\161\163", "\226\161\164", "\226\161\165", "\226\161\166", "\226\161\167", "\226\160\168", "\226\160\169", "\226\160\170", "\226\160\171", "\226\160\172", "\226\160\173", "\226\160\174", "\226\160\175", "\226\161\168", "\226\161\169", "\226\161\170", "\226\161\171", "\226\161\172", "\226\161\173", "\226\161\174", "\226\161\175", "\226\160\176", "\226\160\177", "\226\160\178", "\226\160\179", "\226\160\180", "\226\160\181", "\226\160\182", "\226\160\183", "\226\161\176", "\226\161\177", "\226\161\178", "\226\161\179", "\226\161\180", "\226\161\181", "\226\161\182", "\226\161\183", "\226\160\184", "\226\160\185", "\226\160\186", "\226\160\187", "\226\160\188", "\226\160\189", "\226\160\190", "\226\160\191", "\226\161\184", "\226\161\185", "\226\161\186", "\226\161\187", "\226\161\188", "\226\161\189", "\226\161\190", "\226\161\191", "\226\162\128", "\226\162\129", "\226\162\130", "\226\162\131", "\226\162\132", "\226\162\133", "\226\162\134", "\226\162\135", "\226\163\128", "\226\163\129", "\226\163\130", "\226\163\131", "\226\163\132", "\226\163\133", "\226\163\134", "\226\163\135", "\226\162\136", "\226\162\137", "\226\162\138", "\226\162\139", "\226\162\140", "\226\162\141", "\226\162\142", "\226\162\143", "\226\163\136", "\226\163\137", "\226\163\138", "\226\163\139", "\226\163\140", "\226\163\141", "\226\163\142", "\226\163\143", "\226\162\144", "\226\162\145", "\226\162\146", "\226\162\147", "\226\162\148", "\226\162\149", "\226\162\150", "\226\162\151", "\226\163\144", "\226\163\145", "\226\163\146", "\226\163\147", "\226\163\148", "\226\163\149", "\226\163\150", "\226\163\151", "\226\162\152", "\226\162\153", "\226\162\154", "\226\162\155", "\226\162\156", "\226\162\157", "\226\162\158", "\226\162\159", "\226\163\152", "\226\163\153", "\226\163\154", "\226\163\155", "\226\163\156", "\226\163\157", "\226\163\158", "\226\163\159", "\226\162\160", "\226\162\161", "\226\162\162", "\226\162\163", "\226\162\164", "\226\162\165", "\226\162\166", "\226\162\167", "\226\163\160", "\226\163\161", "\226\163\162", "\226\163\163", "\226\163\164", "\226\163\165", "\226\163\166", "\226\163\167", "\226\162\168", "\226\162\169", "\226\162\170", "\226\162\171", "\226\162\172", "\226\162\173", "\226\162\174", "\226\162\175", "\226\163\168", "\226\163\169", "\226\163\170", "\226\163\171", "\226\163\172", "\226\163\173", "\226\163\174", "\226\163\175", "\226\162\176", "\226\162\177", "\226\162\178", "\226\162\179", "\226\162\180", "\226\162\181", "\226\162\182", "\226\162\183", "\226\163\176", "\226\163\177", "\226\163\178", "\226\163\179", "\226\163\180", "\226\163\181", "\226\163\182", "\226\163\183", "\226\162\184", "\226\162\185", "\226\162\186", "\226\162\187", "\226\162\188", "\226\162\189", "\226\162\190", "\226\162\191", "\226\163\184", "\226\163\185", "\226\163\186", "\226\163\187", "\226\163\188", "\226\163\189", "\226\163\190", "\226\163\191"})
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["braille-table"] = v_0_
  braille_table = v_0_
end
local braille_idx
do
  local v_0_
  local function braille_idx0(x, y)
    return ((2 ^ y) * (16 ^ x))
  end
  v_0_ = braille_idx0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["braille-idx"] = v_0_
  braille_idx = v_0_
end
local __3ebraille
do
  local v_0_
  local function __3ebraille0(...)
    local function _2_(acc, x)
      return (acc + x)
    end
    return braille_table[a.inc(a.reduce(_2_, 0, {...}))]
  end
  v_0_ = __3ebraille0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["->braille"] = v_0_
  __3ebraille = v_0_
end
local get_buffer_lines
do
  local v_0_
  local function get_buffer_lines0(buf)
    return vim.fn.getbufline(buf, 1, "$")
  end
  v_0_ = get_buffer_lines0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-buffer-lines"] = v_0_
  get_buffer_lines = v_0_
end
local lines__3erange_list
do
  local v_0_
  local function lines__3erange_list0(lines)
    local f
    local function _2_(l)
      local ll = #l
      local t = {["end"] = 0, begin = ll}
      local idx_of
      local function _3_(l0, i)
        local idx = a.inc(i)
        return l0:sub(idx, idx)
      end
      idx_of = _3_
      for i = 0, ll do
        if (t.begin < ll) then break end
        if not string["blank?"](idx_of(l, i)) then
          t.begin = i
        end
      end
      for i = ll, 0, -1 do
        if (t["end"] > 1) then break end
        if not string["blank?"](idx_of(l, i)) then
          t["end"] = i
        end
      end
      return t
    end
    f = _2_
    return a.map(f, lines)
  end
  v_0_ = lines__3erange_list0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["lines->range-list"] = v_0_
  lines__3erange_list = v_0_
end
local scale
do
  local v_0_
  local function scale0(factor, ls)
    local x_factor = factor
    local __3escale
    local function _2_(l)
      return {["end"] = (l["end"] * x_factor), begin = (l.begin * x_factor)}
    end
    __3escale = _2_
    return a.map(__3escale, ls)
  end
  v_0_ = scale0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["scale"] = v_0_
  scale = v_0_
end
local __3echunks
do
  local v_0_
  local function __3echunks0(n, ls)
    local t = {i = 0, result = {}, tmp = {}}
    for i, l in ipairs(ls) do
      table.insert(t.tmp, l)
      if (t.i == a.dec(n)) then
        table.insert(t.result, t.tmp)
        t.tmp = {}
        t.i = 0
      else
        t.i = a.inc(t.i)
      end
    end
    if not a["empty?"](t.tmp) then
      table.insert(t.result, t.tmp)
    end
    return t.result
  end
  v_0_ = __3echunks0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["->chunks"] = v_0_
  __3echunks = v_0_
end
local __3eline
do
  local v_0_
  local function __3eline0(chunk)
    local result = ""
    for i = 0, 100, 2 do
      local b_idx = 0
      for j, v in ipairs(chunk) do
        local begin = v.begin
        local _end = v["end"]
        local di = a.dec(i)
        local dj = a.dec(j)
        if ((begin <= di) and (_end > di)) then
          b_idx = (b_idx + braille_idx(0, dj))
        end
        if ((begin <= i) and (_end > i)) then
          b_idx = (b_idx + braille_idx(1, dj))
        end
      end
      result = (result .. __3ebraille(b_idx))
    end
    return result
  end
  v_0_ = __3eline0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["->line"] = v_0_
  __3eline = v_0_
end
local __3eminimap_lines
do
  local v_0_
  local function __3eminimap_lines0(chunks)
    return a.map(__3eline, chunks)
  end
  v_0_ = __3eminimap_lines0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["->minimap-lines"] = v_0_
  __3eminimap_lines = v_0_
end
local minimap
do
  local v_0_
  do
    local v_0_0
    local function minimap0(buf)
      return __3eminimap_lines(__3echunks(4, scale(0.25, lines__3erange_list(get_buffer_lines(buf)))))
    end
    v_0_0 = minimap0
    _0_0["minimap"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["minimap"] = v_0_
  minimap = v_0_
end
-- (->braille (braille-idx 0 0)) (->braille (braille-idx 0 0) (braille-idx 1 0) (braille-idx 0 2)) (scale 0.25 table: 0x7f4f2ef8b3d0) (->chunks 4 table: 0x7f4f2f144e80) (->line table: 0x7f4f2f0fe188) (minimap (vim.fn.bufnr %))
return nil