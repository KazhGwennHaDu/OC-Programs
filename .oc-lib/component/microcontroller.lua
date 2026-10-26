---@meta _
---@source https://ocdoc.cil.li/component:microcontroller

---@class oc.component.microcontroller:oc.component.proxy
local microcontroller = { type = "microcontroller" }

--- Returns whether the microcontroller is running.
--- 
---@return boolean
---@nodiscard
function isRunning() end

--- Starts the microcontroller.
--- Returns true if the state changed.
--- 
---@return boolean
function start() end

--- Stops the microcontroller.
--- Returns true if the state changed.
--- 
---@return boolean
function stop() end

--- Returns the reason the microcontroller crashed, if applicable.
--- Returns nil if no crash has occurred.
--- 
---@return string | nil
---@nodiscard
function lastError() end

--- Get whether network messages are sent via the specified side.
--- 
---@param side integer
---@return boolean
---@nodiscard
function isSideOpen(side) end

--- Set whether network messages are sent via the specified side.
--- 
---@param side integer
---@param open boolean
---@return boolean
function setSideOpen(side, open) end
