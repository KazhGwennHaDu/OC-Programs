---@meta

---@class oc.lib.tty
local tty = {}

---@class oc.lib.tty.window
---@field gpu oc.component.gpu|nil
---@field keyboard oc.component.address|nil
---@field width number
---@field height number
---@field fullscreen boolean
---@field blink boolean
---@field nowrap boolean
---@field dx number
---@field dy number
---@field x number
---@field y number
---@field output_buffer string
tty.window = {
  fullscreen = true,
  blink = true,
  dx = 0,
  dy = 0,
  x = 1,
  y = 1,
  output_buffer = "",
}

---@class oc.lib.tty.stream:oc.api.buffer.istream
tty.stream = {}

---@type table<oc.component.address, boolean>
local screen_cache = {}

---@param gpu oc.component.gpu
---@param addr oc.component.address?
local function screen_reset(gpu, addr) end

---@return number width
---@return number height
---@return number dx
---@return number dy
---@return number x
---@return number y
function tty.getViewport() end

---@param width number
---@param height number
---@param dx number
---@param dy number
---@param x number
---@param y number
function tty.setViewport(width, height, dx, dy, x, y) end

---@return oc.component.gpu|nil
function tty.gpu() end

function tty.clear() end

---@return boolean
function tty.isAvailable() end

-- PLEASE do not use this method directly, use io.read or term.read
---@return string
function tty.stream.read() end

-- PLEASE do not use this method directly, use io.write or term.write
---@param value string
---@return integer
function tty.stream:write(value) end

---@return integer col
---@return integer row
function tty.getCursor() end

---@param col integer
---@param row integer
function tty.setCursor(col, row) end

---@type table<oc.component.gpu, boolean>
local gpu_intercept = {}

---@param gpu oc.component.gpu
function tty.bind(gpu) end

---@return oc.component.address|string
function tty.keyboard() end

---@return oc.component.address|nil
function tty.screen() end

---@param lines integer?
---@return integer
function tty.stream.scroll(lines) end

-- stream methods
local function bfd() return nil, "tty: invalid operation" end
tty.stream.close = bfd
tty.stream.seek = bfd
tty.stream.handle = "tty"

return tty
