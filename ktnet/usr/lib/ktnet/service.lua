local event = require "event"
local network = require "network"
local thread = require "thread"

local config = require "ktnet.config"

-- Constants

-- tcp timeout: 1[s]
local TCP_TIMEOUT = 1

-- Statics

local interrupt_sig = false

-- Private

local this = {
    config = nil,
    ---@type table<string, OC.ThreadHandle>
    sessions = {},

    stop_sig = nil,
}

local function interrupt_handler()
    interrupt_sig = true
    return false
end

-- Public

local service = {}

---ktnet service loop
---
---listens on the configured `PORT` and creates new ktnet sessions.
---@param stop_sig? fun(): boolean
function service.run(stop_sig)
    if stop_sig then
        this.stop_sig = stop_sig
    else
        interrupt_sig = false
        this.stop_sig = function () return interrupt_sig end
        event.listen("interrupted", interrupt_handler)
    end

    this.config = config.load()
    network.tcp.listen(this.config.PORT)

    while not this.stop_sig() do
        local evt, _, channel, remote_address, _ = event.pull(TCP_TIMEOUT, "tcp", "connection", nil, nil, this.config.PORT)
        if evt ~= nil then
            local session_conn = channel .. "@" .. remote_address
            if this.sessions[session_conn] == nil then
                this.sessions[session_conn] = thread.create(function ()
                    -- TODO: sessions
                    os.sleep(10)
                end, channel, remote_address)
            else
                -- What to do if session already exists ?
            end
        end

        -- Clean dead sessions

        ---@type string[]
        local to_delete = {}
        for k, t in pairs(this.sessions) do
            if t:status() == "dead" then
                table.insert(to_delete, k)
            end
        end
        for _, k in pairs(to_delete) do
            this.sessions[k] = nil
        end
    end

    network.tcp.unlisten(this.config.PORT)

    -- Should we kill all sessions ?
end

return service
