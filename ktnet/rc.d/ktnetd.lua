local daemon = require "ktnet.daemon"

-- Helper

---@param status "running" | "suspended" | "dead" | "stopped"
---@return string
local function getStatusColor(status)
    local colors = {
        ["running"]   = "",
        ["suspended"] = "",
        ["dead"]      = "",
        ["stopped"]   = "",
    }
    return colors[status] or ""
end

-- rc.d

function start()
    local ok, reason = daemon.start()
    if not ok then
        print(reason)
    end
end

function stop()
    local ok, reason = daemon.stop()
    if not ok then
        print(reason)
    end
end

function status()
    local status = daemon.status()
    local color = getStatusColor(status)
    print("ktnet " .. color .. status)
end
