---@meta
---@source https://ocdoc.cil.li/api:uuid

---@alias uuid string

-- UUID API

---@class OC.UUID
local uuid_api = {}

---Returns 128 bit random identifiers, represented as a hex value in a string grouped by 8, 4, 4, 4, and 12 hex characters, separated by dashes.
---
---e.g. `34eb7b28-14d3-4767-b326-dd1609ba92e`. You might recognize this pattern as it is the same used for component addressing. 
---@return uuid
function uuid_api.next() end

return uuid_api
