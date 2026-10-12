---@meta _
---@source https://ocdoc.cil.li/component:computer

---@class oc.component.computer:oc.component.proxy
local computer = { type = "computer" }

--- Tries to start the computer.
--- Returns true on success, false otherwise.
--- 
--- Note that this will also return false if the computer was already running.
--- If the computer is currently shutting down, this will cause the computer to reboot instead.
--- 
---@return boolean
function computer.start() end

--- Tries to stop the computer.
--- Returns true on success, false otherwise.
--- Also returns false if the computer is already stopped.
--- 
---@return boolean
function computer.stop() end

--- Returns whether the computer is currently running.
--- 
---@return boolean
---@nodiscard
function computer.isRunning() end

--- Plays a tone, useful to alert users via audible feedback.
--- Supports frequencies from 20 to 2000Hz, with a duration of up to 5 seconds.
--- 
--- This method is overloaded taking a single string parameter
--- as a pattern of dots `.` and dashes `-` for short and long beeps respectively.
--- 
---@overload fun(pattern: string)
---@param frequency number? between 20 and 2000.
---@param duration number? 0 to 5 seconds.
function computer.beep(frequency, duration) end

--- Returns a table of device information.
--- 
--- Note that this is architecture-specific and some may not implement it at all.
--- 
---@return table<oc.component.address, table>
---@nodiscard
function computer.getDeviceInfo() end

--- Attempts to crash the computer for the specified reason.
--- 
---@param reason string
function computer.crash(reason) end

--- Returns the computer's current architecture.
--- 
---@return "Lua 5.2"|"Lua 5.3"
---@nodiscard
function computer.getArchitecture() end

--- Returns whether or not the computer is, in fact, a robot.
--- 
---@return boolean
---@nodiscard
function computer.isRobot() end
