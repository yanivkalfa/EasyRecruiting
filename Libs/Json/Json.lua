Json = {}

-- Internal functions.
local function match(str, pattern, pos)
  local startPos, endPos = string.find(str, pattern, pos);
  if (startPos) then
    return strsub(str, startPos, endPos);
  end
  return nil;
end

local function kind_of(obj)
  if type(obj) ~= 'table' then return type(obj) end
  local i = 1
  for _ in pairs(obj) do
    if obj[i] ~= nil then i = i + 1 else return 'table' end
  end
  if i == 1 then return 'table' else return 'array' end
end

local function escape_str(s)
  local in_char = { '\\', '"', '/', '\b', '\f', '\n', '\r', '\t' }
  local out_char = { '\\', '"', '/', 'b', 'f', 'n', 'r', 't' }
  for i, c in ipairs(in_char) do
    s = string.gsub(s, c, '\\' .. out_char[i])
  end
  return s
end

-- Returns pos, did_find; there are two cases:
-- 1. Delimiter found: pos = pos after leading space + delim; did_find = true.
-- 2. Delimiter not found: pos = pos after leading space;     did_find = false.
-- This throws an error if err_if_missing is true and the delim is not found.
local function skip_delim(str, pos, delim, err_if_missing)
  pos = pos + strlen(match(str, '^%s*', pos))
  if strsub(str, pos, pos) ~= delim then
    if err_if_missing then
      error('Expected ' .. delim .. ' near position ' .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

-- Expects the given pos to be the first character after the opening quote.
-- Returns val, pos; the returned pos is after the closing quote character.
local function parse_str_val(str, pos, val)
  val = val or ''
  local early_end_error = 'End of input found while parsing string.'
  if pos > strlen(str) then error(early_end_error) end
  local c = strsub(str, pos, pos)
  if c == '"' then return val, pos + 1 end
  if c ~= '\\' then return parse_str_val(str, pos + 1, val .. c) end
  -- We must have a \ character.
  local esc_map = { b = '\b', f = '\f', n = '\n', r = '\r', t = '\t' }
  local nextc = strsub(str, pos + 1, pos + 1)
  if not nextc then error(early_end_error) end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

-- Returns val, pos; the returned pos is after the number's final character.
local function parse_num_val(str, pos)
  local num_str = match(str, '^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
  local val = tonumber(num_str)
  if not val then error('Error parsing number at position ' .. pos .. '.') end
  return val, pos + strlen(num_str)
end


-- Public values and functions.

function Json.stringify(obj, as_key)
  local s = {} -- We'll build the string as an array of strings to be concatenated.
  local kind = kind_of(obj) -- This is 'array' if it's an array or type(obj) otherwise.
  if kind == 'array' then
    if as_key then error('Can\'t encode array as key.') end
    s[table.getn(s) + 1] = '['
    for i, val in ipairs(obj) do
      if i > 1 then s[table.getn(s) + 1] = ', ' end
      s[table.getn(s) + 1] = Json.stringify(val)
    end
    s[table.getn(s) + 1] = ']'
  elseif kind == 'table' then
    if as_key then error('Can\'t encode table as key.') end
    s[table.getn(s) + 1] = '{'
    for k, v in pairs(obj) do
      if table.getn(s) > 1 then s[table.getn(s) + 1] = ', ' end
      s[table.getn(s) + 1] = Json.stringify(k, true)
      s[table.getn(s) + 1] = ':'
      s[table.getn(s) + 1] = Json.stringify(v)
    end
    s[table.getn(s) + 1] = '}'
  elseif kind == 'string' then
    return '"' .. escape_str(obj) .. '"'
  elseif kind == 'number' then
    if as_key then return '"' .. tostring(obj) .. '"' end
    return tostring(obj)
  elseif kind == 'boolean' then
    return tostring(obj)
  elseif kind == 'nil' then
    return 'null'
  else
    error('Unjsonifiable type: ' .. kind .. '.')
  end
  return table.concat(s)
end

Json.null = {} -- This is a one-off table to represent the null value.

function Json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > strlen(str) then error('Reached unexpected end of input.') end
  local pos = pos + strlen(match(str, '^%s*', pos)) -- Skip whitespace.
  local first = strsub(str, pos, pos)
  if first == '{' then -- Parse an object.
    local obj, key, delim_found = {}, true, true
    pos = pos + 1
    while true do
      key, pos = Json.parse(str, pos, '}')
      if key == nil then return obj, pos end
      if not delim_found then error('Comma missing between object items.') end
      pos = skip_delim(str, pos, ':', true) -- true -> error if missing.
      obj[key], pos = Json.parse(str, pos)
      pos, delim_found = skip_delim(str, pos, ',')
    end
  elseif first == '[' then -- Parse an array.
    local arr, val, delim_found = {}, true, true
    pos = pos + 1
    while true do
      val, pos = Json.parse(str, pos, ']')
      if val == nil then return arr, pos end
      if not delim_found then error('Comma missing between array items.') end
      arr[table.getn(arr) + 1] = val
      pos, delim_found = skip_delim(str, pos, ',')
    end
  elseif first == '"' then -- Parse a string.
    return parse_str_val(str, pos + 1)
  elseif first == '-' or match(first, '%d') then -- Parse a number.
    return parse_num_val(str, pos)
  elseif first == end_delim then -- End of an object or array.
    return nil, pos + 1
  else -- Parse true, false, or null.
    local literals = { ['true'] = true, ['false'] = false, ['null'] = Json.null }
    for lit_str, lit_val in pairs(literals) do
      local lit_end = pos + strlen(lit_str) - 1
      if strsub(str, pos, lit_end) == lit_str then return lit_val, lit_end + 1 end
    end
    local pos_info_str = 'position ' .. pos .. ': ' .. strsub(str, pos, pos + 10)
    error('Invalid json syntax starting at ' .. pos_info_str)
  end
end

