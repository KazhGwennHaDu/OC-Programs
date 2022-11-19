--[[
    DNKazh

    Created by KazhGwennHaDu

    DNS API
]]

local version = 1.0

local port = 53
local host

local event = require('event')
local component = require('component')

local error = require('utilikazh').error
local serial = require('utilikazh').serial

if not component.isAvailable('modem') then
    error.fail("The API DNKazh requires a network card to work")
    os.exit()
end
local modem = component.modem

-- API
local dns = {}

function dns.whodns()
    local _, payload = serial.encode({request = 'whodns'})
    modem.broadcast(port, payload)

    modem.open(port)
    local _, payload = serial.encode({response = 'whodns'}) -- Payload to receive
    local _,_, remote = event.pull(5, 'modem_message', nil, nil, port, nil, payload)
    modem.close(port)
    return remote
end

function dns.version()
    return version
end

host = dns.whodns()
return dns