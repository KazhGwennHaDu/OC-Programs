---@meta

---@type table<string[], fun(window: oc.lib.tty.window, ...: string)>
local rules = {}

---@class oc.lib.vt100
local vt100 = { rules=rules }

-- colors, blinking, and reverse
-- [%d+;%d+;..%d+m
-- cost: 2,250
rules[{"%[", "[%d;]*", "m"}] = function(window, _, number_text) end

-- 7    save cursor position and attributes
-- 8    restore cursor position and attributes
rules[{"[78]"}] = function (window, seven, s) end

-- s    save cursor position
-- u    restore cursor position
rules[{"%[", "[su]"}] = function (window, seven, s) end

-- [?7[hl]        wrap mode
rules[{"%[", "%?", "7", "[hl]"}] = function(window, _, _, _, nowrap) end

-- helper scroll function
local function set_cursor(window, x, y) end

-- -- These DO NOT SCROLL
-- [(%d*)A        move cursor up n lines
-- [(%d*)B        move cursor down n lines
-- [(%d*)C        move cursor right n lines
-- [(%d*)D        move cursor left n lines
rules[{"%[", "%d*", "[ABCD]"}] = function(window, _, n, dir) end

-- [Line;ColumnH  Move cursor to screen location v,h
-- [Line;Columnf  ^ same
-- [;H            Move cursor to upper left corner
-- [;f            ^ same
rules[{"%[", "%d*", ";", "%d*", "[Hf]"}] = function(window, _, y, _, x) end

-- [H             move cursor to upper left corner
-- [f             ^ same
rules[{"%[[Hf]"}] = function(window) end

-- [K             clear line from cursor right
-- [0K            ^ same
-- [1K            clear line from cursor left
-- [2K            clear entire line
rules[{"%[", "[012]?", "K"}] = function(window, _, n) end

-- [J             clear screen from cursor down
-- [0J            ^ same
-- [1J            clear screen from cursor up
-- [2J            clear entire screen
rules[{"%[", "[012]?", "J"}] = function(window, _, n) end

-- [6n            get the cursor position [ EscLine;ColumnR 	Response: cursor is at v,h ]
-- this solution puts the response on stdin, but it isn't echo'd
-- I'm personally fine with the lack of echo
rules[{"%[", "6", "n"}] = function(window) end

-- D               scroll up one line -- moves cursor down
-- E               move to next line (acts the same ^, but x=1)
-- M               scroll down one line -- moves cursor up
rules[{"[DEM]"}] = function(window, _, dir) end

--- Parses VT100 escape sequences.
--- 
---@param window oc.lib.tty.window
---@return string
function vt100.parse(window) end

return vt100
