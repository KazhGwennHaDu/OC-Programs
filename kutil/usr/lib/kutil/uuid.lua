---@class uuidlib
---@field next function
local uuid = require "uuid"

local UUID_MATCH = "%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x"

---@param str string
---@return string?
function uuid.find(str)
    return string.match(str, UUID_MATCH)
end

---@param str string
---@return boolean
function uuid.check(str)
    return string.match(str, "^"..UUID_MATCH.."$") ~= nil
end

return uuid
