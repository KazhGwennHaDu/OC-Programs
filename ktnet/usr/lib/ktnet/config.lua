local fs = require "filesystem"
local serial = require "serialization"

-- Contants

local CONFIG_PATH = "/etc/ktnetd.cfg"

local DEFAULT = {
    PORT = 23
}

-- Private

---comment
---@param path string
---@return table?
local function loadFromFile(path)
    return nil
end

-- Public

local config = {}

function config.load()
    local c = nil
    if fs.exists(CONFIG_PATH) then
        c = loadFromFile(CONFIG_PATH)
    end
    if c == nil then
        c = DEFAULT
        -- TODO: Save to CONFIG_PATH
    end
    return c
end

return config
