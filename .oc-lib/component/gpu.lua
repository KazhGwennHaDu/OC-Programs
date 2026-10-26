---@meta _
---@source https://ocdoc.cil.li/component:gpu

---@class oc.component.gpu:oc.component.proxy
local gpu = { type = "gpu" }

--- Tries to bind the GPU to a screen with the specified address.
--- Returns true on success, false and an error message on failure.
--- Resets the screen's settings if reset is 'true'. A GPU can only be bound to one screen at a time.
--- All operations on it will work on the bound screen.
--- If you wish to control multiple screens at once, you'll need to put more than one graphics card into your computer.
--- 
---@param address oc.component.address
---@param reset boolean
---@return boolean, string?
function gpu.bind(address, reset) end

--- Get the address of the screen the GPU is bound to. Since 1.3.2.
--- 
---@return oc.component.address
---@nodiscard
function gpu.getScreen() end

--- Gets the current background color. This background color is applied to all "pixels" that get changed by other operations.
--- 
--- Note that the returned number is either an RGB value in hexadecimal format, i.e. 0xRRGGBB, or a palette index.
--- The second returned value indicates which of the two it is (true for palette color, false for RGB value).
--- 
---@return integer color
---@return boolean is_index
---@nodiscard
function gpu.getBackground() end

--- Sets the background color to apply to "pixels" modified by other operations from now on.
--- The returned value is the old background color,
--- as the actual value it was set to (i.e. not compressed to the color space currently set).
--- The first value is the previous color as an RGB value.
--- If the color was from the palette, the second value will be the index in the palette.
--- Otherwise it will be nil. Note that the color is expected to be specified in hexadecimal RGB format, i.e. 0xRRGGBB.
--- This is to allow uniform color operations regardless of the color depth supported by the screen and GPU.
--- 
---@param color integer
---@param is_index boolean
---@return integer old_color_rgb
---@return integer? old_color_index
function gpu.setBackground(color, is_index) end

--- Like getBackground, but for the foreground color.
--- 
---@return integer color
---@return boolean is_index
---@nodiscard
function gpu.getForeground() end

--- Like setBackground, but for the foreground color.
--- 
---@param color integer
---@param is_index boolean
---@return integer old_color_rgb
---@return integer? old_color_index
function gpu.setForeground(color, is_index) end

--- Gets the RGB value of the color in the palette at the specified index.
--- 
---@param index integer
---@return integer
---@nodiscard
function gpu.getPaletteColor(index) end

--- Sets the RGB value of the color in the palette at the specified index.
--- 
---@param index integer
---@param value integer
---@return integer
function gpu.setPaletteColor(index, value) end

--- Gets the maximum supported color depth supported by the GPU and the screen it is bound to (minimum of the two).
--- 
---@return oc.component.color_depth
---@nodiscard
function gpu.maxDepth() end

--- The currently set color depth of the GPU/screen, in bits. Can be 1, 4 or 8.
--- 
---@return oc.component.color_depth
---@nodiscard
function gpu.getDepth() end

--- Sets the color depth to use.
--- Can be up to the maximum supported color depth.
--- If a larger or invalid value is provided it will throw an error.
--- Returns the old depth as one of the strings OneBit, FourBit, or EightBit.
--- 
---@param bit oc.component.color_depth
---@return oc.component.color_depth_string old_depth
function gpu.setDepth(bit) end

--- Gets the maximum resolution supported by the GPU and the screen it is bound to (minimum of the two).
--- 
---@return integer width
---@return integer height
---@nodiscard
function gpu.maxResolution() end

--- Gets the currently set resolution.
--- 
---@return integer width
---@return integer height
---@nodiscard
function gpu.getResolution() end

--- Sets the specified resolution. Can be up to the maximum supported resolution.
--- If a larger or invalid resolution is provided it will throw an error.
--- Returns true if the resolution was changed (may return false if an attempt was made to set it to the same value it was set before), false otherwise.
--- 
---@param width integer
---@param height integer
---@return boolean
function gpu.setResolution(width, height) end

--- Get the current viewport resolution.
--- 
---@return integer width
---@return integer height
---@nodiscard
function gpu.getViewport() end

--- Set the current viewport resolution.
--- Returns true if it was changed (may return false if an attempt was made to set it to the same value it was set before), false otherwise.
--- This makes it look like screen resolution is lower, but the actual resolution stays the same.
--- Characters outside top-left corner of specified size are just hidden, and are intended for rendering or storing things off-screen and copying them to the visible area when needed.
--- Changing resolution will change viewport to whole screen.
--- 
---@param width integer
---@param height integer
---@return boolean
function gpu.setViewport(width, height) end

---@deprecated Use screen.getAspectRatio().
---
--- Gets the size in blocks of the screen the graphics card is bound to.
--- For simple screens and robots this will be one by one.
--- 
---@return integer width
---@return integer height
---@nodiscard
function gpu.getSize() end

--- Gets the character currently being displayed at the specified coordinates.
--- The second and third returned values are the fore- and background color, as hexvalues.
--- If the colors are from the palette, the fourth and fifth values specify the palette index of the color, otherwise they are nil.
--- 
---@param x integer
---@param y integer
---@return string character
---@return integer fg_rgb
---@return integer bg_rgb
---@return integer? fg_index
---@return integer? bg_index
---@nodiscard
function gpu.get(x, y) end

--- Writes a string to the screen, starting at the specified coordinates.
--- The string will be copied to the screen's buffer directly, in a single row.
--- This means even if the specified string contains line breaks, these will just be printed as special characters,
--- the string will not be displayed over multiple lines.
--- Returns true if the string was set to the buffer, false otherwise.
--- 
--- The optional fourth argument makes the specified text get printed vertically instead, if true.
--- 
---@param x integer
---@param y integer
---@param value string
---@param vertical boolean?
---@return boolean
function gpu.set(x, y, value, vertical) end

--- Copies a portion of the screens buffer to another location.
--- The source rectangle is specified by the x, y, width and height parameters.
--- The target rectangle is defined by x + tx, y + ty, width and height.
--- Returns true on success, false otherwise.
--- 
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param tx integer
---@param ty integer
---@return boolean
function gpu.copy(x, y, width, height, tx, ty) end

--- Fills a rectangle in the screen buffer with the specified character.
--- The target rectangle is specified by the x and y coordinates and the rectangle's width and height.
--- The fill character char must be a string of length one, i.e. a single character.
--- Returns true on success, false otherwise.
--- 
--- Note that filling screens with spaces ( ) is usually less expensive,
--- i.e. consumes less energy, because it is considered a “clear” operation (see config).
--- 
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param char string
---@return boolean
function gpu.fill(x, y, width, height, char) end

-- Buffer Operations

--- Returns the index of the currently selected buffer.
--- 0 is reserved for the screen, and may return 0 even when there is no screen.
--- 
---@return integer
---@nodiscard
function gpu.getActiveBuffer() end

--- Sets the active buffer to index.
--- 0 is reserved for the screen and can be set even when there is no screen.
--- 
--- Returns nil for an invalid index (0 is valid even with no screen).
--- 
---@param index integer
---@return integer | nil
function gpu.setActiveBuffer(index) end

--- Returns an array of all current page indexes (0 is not included in this list, that is reserved for the screen).
--- 
---@return integer[]
---@nodiscard
function gpu.buffers() end

--- Allocates a new buffer with dimensions width*heigh (gpu max resolution by default).
--- 
--- Returns the index of this new buffer or error when there is not enough video memory.
--- A buffer can be allocated even when there is no screen bound to this gpu.
--- 
--- Index 0 is always reserved for the screen and thus the lowest possible index of an allocated buffer is always 1.
--- 
---@param width integer?
---@param height integer?
---@return integer
---@nodiscard
function gpu.allocateBuffer(width, height) end

--- Removes buffer at index (default: current buffer index).
--- 
--- Returns true if the buffer was removed.
--- When you remove the currently selected buffer,
--- the gpu automatically switches back to index 0 (reserved for a screen).
--- 
---@param index integer?
---@return boolean
function gpu.freeBuffer(index) end

--- Removes all buffers, freeing all video memory.
--- The buffer index is always 0 after this call.
--- 
function gpu.freeAllBuffers() end

--- Returns the total memory size of the gpu vram. This does not include the screen.
--- 
---@return integer
---@nodiscard
function gpu.totalMemory() end

--- Returns the total free memory not allocated to buffers.
--- This does not include the screen.
--- 
---@return integer
---@nodiscard
function gpu.freeMemory() end

--- Returns the buffer size at index (default: current buffer index).
--- Returns the screen resolution for index 0.
--- Returns nil for invalid indexes.
--- 
---@param index integer?
---@return integer | nil width
---@return integer | nil height
---@nodiscard
function gpu.getBufferSize(index) end

--- Copy a region from buffer to buffer, screen to buffer, or buffer to screen.
--- 
--- Defaults:
--- - dst = 0, the screen
--- - col, row = 1,1
--- - width, height = resolution of the destination buffer
--- - src = the current buffer
--- - fromCol, fromRow = 1,1
--- 
--- bitblt should preform very fast on repeated use.
--- 
--- If the buffer is dirty there is an initial higher cost to sync the buffer with the destination object.
--- If you have a large number of updates to make with frequent bitblts, consider making multiple and smaller buffers.
--- If you plan to use a static buffer (one with few or no updates), then a large buffer is just fine.
--- 
--- Returns true on success.
--- 
---@param dst integer
---@param col integer
---@param row integer
---@param width integer
---@param height integer
---@param src integer
---@param fromCol integer
---@param fromRow integer
---@return boolean
function gpu.bitblt(dst, col, row, width, height, src, fromCol, fromRow) end
