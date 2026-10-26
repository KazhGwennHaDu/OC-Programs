---@meta _
---@source https://ocdoc.cil.li/component:screen

---@class oc.component.screen:oc.component.proxy
local screen = { type = "screen" }

--- Returns whether the screen is currently on.
--- 
---@return boolean
---@nodiscard
function screen.isOn() end

--- Turns the screen on.
--- 
--- Returns whether it was off and the new power state.
--- 
---@return boolean, boolean
function screen.turnOn() end

--- Turns off the screen.
--- 
--- Returns whether it was on and the new power state.
--- 
---@return boolean, boolean
function screen.turnOff() end

--- The aspect ratio of the screen.
--- 
--- For multi-block screens this is the number of blocks, horizontal and vertical.
--- 
---@return integer, integer
---@nodiscard
function screen.getAspectRatio() end

--- The list of keyboards attached to the screen.
--- 
---@return oc.component.address[]
---@nodiscard
function screen.getKeyboards() end

--- Set whether to use high-precision mode (sub-pixel mouse event position).
--- 
--- Requires Screen (Tier 3).
--- 
---@param enabled boolean
---@return boolean
function screen.setPrecise(enabled) end

--- Check whether high-precision mode is enabled (sub-pixel mouse event position).
--- 
--- Requires Screen (Tier 3).
--- 
---@return boolean
---@nodiscard
function screen.isPrecise() end

--- Sets Inverted Touch mode (Sneak-activate opens GUI if set to true).
--- 
---@param enabled boolean
---@return boolean
function screen.setTouchModeInverted(enabled) end

--- Check to see if Inverted Touch mode is enabled (Sneak-activate opens GUI is set to true).
--- 
---@return boolean
---@nodiscard
function screen.isTouchModeInverted() end
