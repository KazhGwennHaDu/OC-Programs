---@meta
---@source https://ocdoc.cil.li/api:text

--- This API provides some more general operations on strings and data serialization into and back from strings.
--- 
---@class OC.Text
local text_api = {}

--- Converts tabs in a string to spaces, while aligning the tags at the specified tab width.
--- This is used for formatting text in term.write, for example.
--- 
---@param s string
---@param tab_width integer
---@return string
function text_api.detab(s, tab_width) end

--- Pads a string with whitespace on the right up to the specified length.
--- 
---@param s string
---@param length integer
---@return string
function text_api.padRight(s, length) end

--- Pads a string with whitespace on the left up to the specified length.
--- 
---@param s string
---@param length integer
---@return string
function text_api.padLeft(s, length) end

--- Removes whitespace characters from the start and end of a string.
--- 
---@param s string
---@return string
function text_api.trim(s) end

--- Wraps the provided string to specified width.
--- 
---@param s string
---@param width integer
---@param max_width integer
---@return string, string, boolean
function text_api.wrap(s, width, max_width) end

--- Returns a wrapper function around text.wrap.
--- 
---@param s string
---@param width integer
---@param max_width integer
---@return fun(): string
function text_api.wrappedLines(s, width, max_width) end

--- Splits the input string into a table, using space as the delimiter.
--- 
---@param s string
---@return string[]
function text_api.tokenize(s) end

--- Splits input into an array for sub strings delimited by delimiters.
--- Delimiters are included in the result if not `drop_delims`.
--- 
---@param s string
---@param delimiters string[]
---@param drop_delims boolean?
---@param di integer?
---@return string[]
function text_api.split(s, delimiters, drop_delims, di) end

return text_api
