-- LIBRARIES

local component = require "component"
local event     = require "event"
local network   = require "network"
local shell     = require "shell"
local term      = require "term"
local thread    = require "thread"

-- FUNCTIONS

local function loadConfig()
  local env = {
    PORT = 23
  }
  return env
end

-- SESSION HANDLER

local function tnetSession(channel, remote_address)

end

-- PROGRAM SETUP

local config = loadConfig()

local running = true
local sessions = {}

local interrupt_handle = event.listen("interrupted", function()
  running = false
end)

network.tcp.listen(config.PORT)

-- PROGRAM LOOP

while running then
  local evt, _, channel, remote_address, _ = event.pull(30, "tcp", "connection", nil, nil, config.PORT)
  if evt ~= nil then
    local session_t = thread.create(tnetSession, channel, remote_address)
    sessions[channel .. "@" remote_address] = session_t
  end
  local to_delete = {}
  for k, t in pairs(sessions) do
    if t:status() == "dead" then
      table.insert(to_delete, k)
    end
  end
  for _, k in pairs(to_delete) do
    sessions[k] = nil
  end
end

-- PROGRAM EXIT

print("Exiting...")

network.tcp.unlisten(config.PORT)

event.cancel(interrupt_handle)