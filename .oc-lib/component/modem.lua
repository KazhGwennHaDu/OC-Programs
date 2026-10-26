---@meta _
---@source https://ocdoc.cil.li/component:modem

---@class oc.component.modem:oc.component.proxy
local modem = { type = "modem" }

--- Returns the maximum packet size for sending messages via network cards. Defaults to `8192`.
--- You can change this in the OpenComputers configuration file.
--- 
--- Every value in a message adds two bytes of overhead. (Even if there's only one value.)
--- Numbers add another 8 bytes, true/false/nil another 4 bytes,
--- and strings exactly as many bytes as the string contains—though empty strings still count as one byte.
--- 
--- Examples:
--- - `"foo"` is a 5-byte packet; two bytes of overhead and a three byte string.
--- - `"currentStatus", 300` is a 25-byte packet; four bytes overhead, a 13-byte string, and 8 bytes for a number.
--- 
---@return integer
---@nodiscard
function maxPacketSize() end

--- Returns whether the specified "port" is currently being listened on.
--- 
--- Messages only trigger signals when they arrive on a port that is open.
--- 
---@param port integer
---@return boolean
---@nodiscard
function isOpen(port) end

--- Opens the specified port number for listening.
--- 
--- Returns true if the port was opened, false if it was already open.
--- 
--- Note: maximum port is `65535`
--- 
---@param port integer
---@return boolean
function open(port) end

--- Closes the specified port (default: all ports).
--- 
--- Returns true if ports were closed.
--- 
---@param port integer?
---@return boolean
function close(port) end

--- Sends a network message to the specified address.
--- 
--- Returns true if the message was sent.
--- This does not mean the message was received, only that it was sent.
--- No port-sniffing for you.
--- 
--- Any additional arguments are passed along as data.
--- These arguments must be basic types: nil, boolean, number and string values are supported, tables and functions are not.
--- See the serialization API for serialization of tables.
--- 
--- The number of additional arguments is limited.
--- The default limit is 8.
--- It can be changed in the OpenComputers configuration file, but this is not recommended;
--- higher limits can allow relatively weak computers to break relatively strong ones with no defense possible,
--- while lower limits will prevent some protocols from working.
--- 
---@param address oc.component.address
---@param port integer
---@param ... any
---@return boolean
function send(address, port, ...) end

--- Sends a broadcast message.
--- This message is delivered to all reachable network cards.
--- 
--- Returns true if the message was sent.
--- 
--- Note that broadcast messages are not delivered to the modem that sent the message.
--- 
--- All additional arguments are passed along as data. See send.
--- 
---@param port integer
---@param ... any
---@return boolean
function broadcast(port, ...) end

--- Returns whether this modem is capable of sending wireless messages.
--- 
---@return boolean
---@nodiscard
function isWireless() end

--- The current signal strength to apply when sending messages.
--- 
--- Wireless network cards only.
--- 
---@return number
---@nodiscard
function getStrength() end

--- Sets the signal strength.
--- 
--- If this is set to a value larger than zero, sending a message will also generate a wireless message.
--- Also, calls to set the strength that exceed the installed modem's maximum strength will simply set the modem's strength to it's maximum.
--- The higher the signal strength the more energy is required to send messages, though.
--- 
--- Wireless network cards only.
--- 
---@param value number
---@return number
function setStrength(value) end

--- Gets the current wake-up message.
--- 
--- When the network card detects the wake message (a string in the first argument of a network packet)
--- on any port and the machine is off, the machine is started.
--- 
--- Works for robots, cases, servers, drones, and tablets.
--- Linked Cards provide this same functionality.
--- 
---@return string
---@nodiscard
function getWakeMessage() end

--- Sets the wake-up message to the specified string.
--- 
--- The message matching can be fuzzy (default is false)
--- A fuzzy match ignores additional trailing arguments in the network packet.
--- 
---@param message string
---@param fuzzy boolean?
---@return string
function setWakeMessage(message, fuzzy) end
