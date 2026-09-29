---@meta
---@source https://ocdoc.cil.li/api:rc

-- RC API

--- The rc system automates running scripts as services and is generally used for starting scripts when the system is booting up.
--- 
---@class oc.api.rc
local rc = {}

---@type string[]
rc.loaded = {}

--- You can unload your rc script thereby removing it from the rc cache.
--- This would be necessary if you want to reconsume your configuration,
--- or clear any script globals.
--- 
--- It can definitely be helpful when debuging and you want to reload your script code without having to reboot the system.
--- 
---@param module string
function rc.unload(module) end

return rc
