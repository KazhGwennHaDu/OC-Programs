--[[
    UtiliKazh

    Created by KazhGwennHaDu


]]

-- Required API's
local uuidLib = require('uuid')
local computer = require('computer')
local serialization = require('serialization')

local version = 1.0

local utilikazh = {
    error = {},
    serial = {},
    uuid = {}
}

-- Error

function utilikazh.error.fail(_err)
    io.stderr:write(_err .. '\n')
    computer.beep()
    os.exit()
end

function utilikazh.error.notice(_err)
    io.stderr:write(_err .. '\n')
    computer.beep()
end

-- Misc

function utilikazh.version()
    return version
end

-- Serialization

function utilikazh.serial.encode(_data)
    return serialization.serialize(_data)
end

function utilikazh.serial.decode(_data)
    local success, result pcall(serialization.unserialize, _data)
    if success then
        return result
    end
    return nil, result
end

-- UUID

utilikazh.uuid.next = uuidLib.next

function utilikazh.uuid.getuuid(_str)
    local success, result = pcall(string.match, _str, '%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x')
    if success then
        return result
    end
    return nil, result
end

function utilikazh.uuid.isuuid(_uuid)
    local success, result = pcall(string.match, _uuid, '^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$')
    return success and result ~= nil
end
