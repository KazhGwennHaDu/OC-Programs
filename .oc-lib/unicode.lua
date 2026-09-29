---@meta
---@source https://ocdoc.cil.li/api:unicode

-- Unicode API

--- Because all strings pass through Java at some point it can be useful to handle them with
--- Unicode support (since Java's internal string representation is UTF-8 encoded).
--- In particular, screens display UTF-8 strings, meaning the related GPU functions expect UTF-8 strings.
--- Also, keyboard input will generally be UTF-8 encoded, especially the clipboard.
--- 
--- However, keep in mind that while wide characters can be displayed,
--- input and output of those is not fully supported in OpenOS's software (i.e. the shell, edit and Lua interpreter).
--- 
---@class oc.api.unicode
local unicode = {}

--- UTF-8 aware version of `string.char`.
--- The values may be in the full UTF-8 range, not just ASCII.
--- 
---@param ... integer
---@return string
---@nodiscard
function unicode.char(...) end

--- Returns the width of the first character given.
--- 
--- For example, for `シ` it'll return `2`, where `a` would return `1`.
--- 
---@param c string
---@return integer
---@nodiscard
function unicode.charWidth(c) end

--- Returns if the width of the first character given is greater than 1.
--- 
--- For example, for `シ` it'll return `true`, where `a` would return `false`.
--- 
---@param c string
---@return boolean
---@nodiscard
function unicode.isWide(c) end

--- UTF-8 aware version of string.len.
--- 
--- For example, for `Ümläüt` it'll return `6`, where `string.len` would return `9`.
--- 
---@param s string
---@return integer
---@nodiscard
function unicode.len(s) end

--- UTF-8 aware version of string.lower.
--- 
---@param s string
---@return string
---@nodiscard
function unicode.lower(s) end

--- UTF-8 aware version of string.reverse.
--- 
--- For example, for Ümläüt it'll return tüälmÜ, where string.reverse would return tälm.
--- 
---@param s string
---@return string
---@nodiscard
function unicode.reverse(s) end

--- UTF-8 aware version of string.sub.
--- 
---@param s string
---@param i integer
---@param j integer
---@return string
---@nodiscard
function unicode.sub(s, i, j) end

--- UTF-8 aware version of string.upper.
--- 
---@param s string
---@return string
---@nodiscard
function unicode.upper(s) end

--- Returns the width of the entire string.
--- 
---@param s string
---@return integer
---@nodiscard
function unicode.wlen(s) end

--- Truncates the given string up to but not including count width.
--- If there are not enough characters to match the wanted width, the function errors.
--- 
---@param s string
---@param count integer
---@return string
---@nodiscard
function unicode.wtrunc(s, count) end

return unicode
