---@class KUtil.stringlib:stringlib
local string = string

---Split a string.
---@param s string
---@param delimiter string
---@return string[]
function string.split(s, delimiter)
  local result = {}
  local pattern = "([^" .. delimiter .. "]+)"

  for w in string.gmatch(s, pattern) do
    table.insert(result, w)
  end
  return result
end

---Trim spaces around the string.
---@param s string
---@return string
function string.trim(s)
  return s:match("^%s*(.-)%s*$")
end

---Trim spaces left of the string.
---@param s string
---@return string
function string.ltrim(s)
  return s:match("^%s*(.*)")
end

---Trim spaces right of the string.
---@param s string
---@return string
function string.rtrim(s)
  return s:match("^(.-)%s*$")
end

return string
