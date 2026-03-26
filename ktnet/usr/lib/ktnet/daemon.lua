local thread = require "thread"

local service = require "ktnet.service"

-- Private

---@type OC.ThreadHandle?
local d_thread = nil
local stop_sig = false

local function stop_sig_h()
    return stop_sig
end

-- Public

local daemon = {}

function daemon.start()
    if d_thread then
        return false, "daemon already started"
    end
    stop_sig = false
    d_thread = thread.create(service.run, stop_sig_h)
    return true, nil
end

function daemon.stop()
    stop_sig = true
    if not d_thread then
        return false, "daemon already stopped"
    end
    if d_thread:status() == "suspended" then
        d_thread:resume()
    end
    repeat
        os.sleep(0.05)
    until d_thread:status() == "dead"
    d_thread = nil
    return true, nil
end

function daemon.status()
    return d_thread and d_thread:status() or "stopped"
end

return daemon
