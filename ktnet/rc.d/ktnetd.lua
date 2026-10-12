local daemon = require "ktnet.daemon"

-- Helper

---@param status "running" | "suspended" | "dead" | "stopped"
---@return string
local function getStatusColor(status)
    local colors = {
        ["running"]   = "\x1B[0;32m",
        ["suspended"] = "\x1B[0;33m",
        ["dead"]      = "\x1B[0;31m",
        ["stopped"]   = "\x1B[0m",
    }
    return colors[status] or "\x1B[0m"
end

-- rc.d

---@diagnostic disable-next-line: lowercase-global
function start()
    local ok, reason = daemon.start()
    if not ok then
        print(reason)
    end
end

---@diagnostic disable-next-line: lowercase-global
function stop()
    local ok, reason = daemon.stop()
    if not ok then
        print(reason)
    end
end

---@diagnostic disable-next-line: lowercase-global
function status()
    local status = daemon.status()
    local color = getStatusColor(status)
    print("ktnet " .. color .. status .. "\x1B[0m")
end
