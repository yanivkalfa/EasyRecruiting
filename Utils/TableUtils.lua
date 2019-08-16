EasyRecruiting.Utils.Table = {};


function EasyRecruiting.Utils.Table.sort(tbl, tSort)
  if (type(tbl) ~= "table" or type(tSort) ~= "table") then
    return tbl;
  end
  local order = type(tSort.O) == "string" and tSort.O or "ASC";
  local orderBy = type(tSort.OB) == "string" and tSort.OB or "I";
  table.sort(tbl, function(a, b)
    if (order == "ASC") then
      return a[orderBy] > b[orderBy];
    else
      return a[orderBy] < b[orderBy];
    end
  end);

  return tbl;
end

local function extendSingle(src, dest)
  for index, value in pairs(dest) do

    if (type(value) == "table" and type(src[index]) == "table") then
      extendSingle(src[index], value);
    else
      src[index] = value;
    end
  end

  return src;
end

function EasyRecruiting.Utils.Table.extend(src, ...)
  for index, value in ipairs(arg) do
    if (type(value) == "table") then
      src = extendSingle(src, value);
    end
  end
  return src;
end

function EasyRecruiting.Utils.Table.argToTable()
  local tbl = {};
  for index, value in ipairs(arg) do
    local pos = table.getn(tbl);
    table.insert(tbl, pos, value);
  end
  return tbl;
end

function EasyRecruiting.Utils.Table.creatPathToTable(tbl)
  for i = 1, table.getn(tbl) do
    if (type(tbl[i]) ~= "number" and type(tbl[i]) ~= "string") then
      return ""
    end
  end
  return EasyRecruiting.Utils.General.implode(".", tbl);
end

-- extending table functionality 
function EasyRecruiting.Utils.Table.slice(tbl, startPos, endPos)
  if (type(tbl) ~= "table") then
    return false;
  end
  local length = table.getn(tbl);
  startPos = startPos or 1;
  endPos = endPos or length;
  local newTbl = {};
  if (type(startPos) == "number" and startPos <= -0) then
    startPos = 1;
  end

  if (type(endPos) == "number" and endPos <= -0) then
    endPos = length;
  end

  if (type(endPos) == "number" and endPos > length) then
    endPos = length
  end

  for i = startPos, endPos do
    table.insert(newTbl, table.getn(newTbl) + 1, tbl[i]);
  end
  return newTbl;
end

function EasyRecruiting.Utils.Table.find(tbl, test)
  if (type(tbl) ~= "table") then
    error("bad argument #1 to 'findIndex' (table expected, got " .. type(tbl) .. ")");
  end
  if (type(test) ~= "function") then
    error("bad argument #2 to 'findIndex' (function expected, got " .. type(tbl) .. ")");
  end
  for index, value in pairs(tbl) do
    if (test(index, value)) then
      return value;
    end
  end
  return false;
end

function EasyRecruiting.Utils.Table.findIndex(tbl, test)
  if (type(tbl) ~= "table") then
    error("bad argument #1 to 'findIndex' (table expected, got " .. type(tbl) .. ")");
  end
  if (type(test) ~= "function") then
    error("bad argument #2 to 'findIndex' (function expected, got " .. type(tbl) .. ")");
  end
  for index, value in pairs(tbl) do
    if (test(index, value)) then
      return index;
    end
  end
  return 0;
end

function EasyRecruiting.Utils.Table.indexOf(tbl, item)
  if (type(tbl) ~= "table") then
    error("bad argument #1 to 'indexOf' (table expected, got " .. type(tbl) .. ")");
  end
  if (not item) then
    error("bad argument #2 to 'indexOf' (function anything, got " .. type(tbl) .. ")");
  end
  for index, value in pairs(tbl) do
    if (value == item) then
      return index;
    end
  end;
  return 0;
end

function EasyRecruiting.Utils.Table.filter(tbl, filter)
  if (type(tbl) ~= "table") then
    error("bad argument #1 to 'filter' (table expected, got " .. type(tbl) .. ")");
  end
  if (type(filter) ~= "function") then
    error("bad argument #2 to 'filter' (function expected, got " .. type(tbl) .. ")");
  end
  local newTbl = {};
  for index, value in pairs(tbl) do
    if (not filter(index, value)) then
      local pos = table.getn(newTbl) + 1;
      table.insert(newTbl, pos, value);
    end
  end

  return newTbl;
end
