---@meta

---@class oc.lib.network
local network = {}

-- IP

network.ip = {}

--- Attaches additional address to this computer, useful for
--- core servers which addresses must be easily rememberable.
--- Address SOULD be up to 64 characters, allowed characters: a-zA-Z, '-'
--- 
---@param addr oc.component.address
function network.ip.bind(addr) end

-- ICMP

network.icmp = {}

--- Sends ping message to addr, message will come back triggering 'ping_reply' event.
--- 
---@param addr oc.component.address
---@param payload string
---@return integer ping_id
function network.icmp.ping(addr, payload) end

-- UDP

network.udp = {}

--- Starts listening on specified port, when data arrives at port "datagram"
--- event is triggered with origin, port, data parameters.
--- 
---@param port integer
function network.udp.open(port) end

--- Stops listening on specified port.
--- 
---@param port integer
function network.udp.close(port) end

--- Sends data to specified host and port. Specified port MUST be open on remote machine.
--- 
---@param addr oc.component.address
---@param port integer
---@param data string
function network.udp.send(addr, port, data) end

-- TCP

network.tcp = {}

--- Starts listening at specified port. When connection arrives event
--- "tcp", "connection", channel, remoteaddr, port
--- is triggered.
--- 
---@param port integer
function network.tcp.listen(port) end

--- Stops listening on specified port.
--- 
--- Note that all connections made to this port will remain untouched.
--- 
---@param port integer
function network.tcp.unlisten(port) end

--- Tries to open a new connection.
--- Will trigger event
--- "tcp", "connection", channel, remoteaddr, port
--- when remote host accepted the connection.
--- 
---@param addr oc.component.address
---@param port integer
---@return integer channel
function network.tcp.open(addr, port) end

--- Closes earlier opened connection.
--- Will trigger
--- "tcp", "close", channel, remoteaddr, port
--- on remote side.
--- 
---@param channel integer
function network.tcp.close(channel) end

--- Sends data to other side.
--- Will trigger
--- "tcp", "message", ch, data, remoteaddr, port
--- event on remote side.
--- 
---@param channel integer
---@param data string
---@return boolean
function network.tcp.send(channel, data) end

-- INFO

network.info = {}

---@class oc.lib.network.info.interface
---@field linkName string | "Ethernet" | "Local Loopback"
---@field selfAddr string | oc.component.address

---@class oc.lib.network.info.interface_info
---@field interfaces table<string, oc.lib.network.info.interface>

---
---@return oc.lib.network.info.interface_info
function network.info.getInfo() end

---@param intf string
---@return integer packet_in
---@return integer packet_out
---@return integer bytes_in
---@return integer bytes_out
function network.info.getInterfaceInfo(intf) end

---@param intf string
---@return oc.component.address[]
function network.info.getArpTable(intf) end

---@class oc.lib.network.info.route
---@field router string | oc.component.address
---@field interface string

---@return oc.lib.network.info.route[]
function network.info.getRoutes() end

return network
