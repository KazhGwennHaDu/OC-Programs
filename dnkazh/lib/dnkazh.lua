--[[
    DNKazh

    Created by KazhGwennHaDu

    DNS API
]]

local version = 1.0

local port = 53
local host = nil

local event = require('event')
local component = require('component')

local uuid = require('utilikazh').uuid
local error = require('utilikazh').error
local serial = require('utilikazh').serial

if not component.isAvailable('modem') then
    error.fail("The API DNKazh requires a network card to work")
    os.exit()
end
local modem = component.modem

-- API
local dns = {}

function dns.getPort()
    return port
end
function dns.setPort(_port)
    local n = tonumber(_port)
    if n ~= nil then
        port = _port
        return true
    end
    return false
end

function dns.getHost()
    return host
end
function dns.setHost(_addr)
    if uuid.isuuid(_addr) then
        host = _addr
        return true
    end
    return false
end

function dns.whodns()
    local _, payload = serial.encode({request = 'whodns'})
    modem.broadcast(port, payload)

    modem.open(port)
    local _, filter = serial.encode({response = 'whodns'}) -- Payload to receive
    local _,_, remote = event.pull(5, 'modem_message', nil, nil, port, nil, filter)
    modem.close(port)
    return remote
end

function dns.autoSetHost()
    local addr = dns.whodns()
    if addr then
        host = addr
        return true
    end
    return false
end

function dns.register(_name, ...)
    local _addr = ...
    local data = {
        request = 'register',
        name = tostring(_name)
    }
    if _addr then
        if not uuid.isuuid(_addr) then
            return false, 'Address malformed'
        end
        data.addr = _addr
    end
    local success, payload = serial.encode(data)
    if not success then
        return false, 'Couldn\'t encode data'
    end
    modem.send(host, port, payload)

    modem.open(port)
    local evt,_,_,_,_, payload = event.pull(5, 'modem_message', nil, host, port)
    modem.close(port)

    if evt == nil then
        return false, 'Timed out'
    end
    local success, data = serial.decode(payload)
    if not success then
        return false, 'Couldn\'t decode received data'
    end

    if data.response ~= 'register' then
        return false, 'Received data malformed'
    end
    if not data.result then
        return false, tostring(data.reason)
    end
    return true, nil
end

function dns.unregister(_name)
    local data = {
        request = 'unregister',
        name = tostring(_name)
    }
    local success, payload = serial.encode(data)
    if not success then
        return false, 'Couldn\'t encode data'
    end
    modem.send(host, port, payload)

    modem.open(port)
    local evt,_,_,_,_, payload = event.pull(5, 'modem_message', nil, host, port)
    modem.close(port)

    if evt == nil then
        return false, 'Timed out'
    end
    local success, data = serial.decode(payload)
    if not success then
        return false, 'Couldn\'t decode received data'
    end

    if data.response ~= 'unregister' then
        return false, 'Received data malformed'
    end
    if not data.result then
        return false, tostring(data.reason)
    end
    return true, nil
end

function dns.runregister(_addr)
    if not uuid.isuuid(_addr) then
        return false, 'Address malformed'
    end
    local data = {
        request = 'runregister',
        addr = _addr
    }
    local success, payload = serial.encode(data)
    if not success then
        return false, 'Couldn\'t encode data'
    end
    modem.send(host, port, payload)

    modem.open(port)
    local evt,_,_,_,_, payload = event.pull(5, 'modem_message', nil, host, port)
    modem.close(port)

    if evt == nil then
        return false, 'Timed out'
    end
    local success, data = serial.decode(payload)
    if not success then
        return false, 'Couldn\'t decode received data'
    end

    if data.response ~= 'runregister' then
        return false, 'Received data malformed'
    end
    if not data.result then
        return false, tostring(data.reason)
    end
    return true, nil
end

function dns.lookup(_name)
    local data = {
        request = 'lookup',
        name = _name
    }
    local success, payload = serial.encode(data)
    if not success then
        return false, 'Couldn\'t encode data'
    end
    modem.send(host, port, payload)

    modem.open(port)
    local evt,_,_,_,_, payload = event.pull(5, 'modem_message', nil, host, port)
    modem.close(port)

    if evt == nil then
        return false, 'Timed out'
    end
    local success, data = serial.decode(payload)
    if not success then
        return false, 'Couldn\'t decode received data'
    end

    if data.response ~= 'lookup' then
        return false, 'Received data malformed'
    end
    if not data.result then
        return false, tostring(data.reason)
    end
    return true, data.result
end

function dns.version()
    return version
end

return dns