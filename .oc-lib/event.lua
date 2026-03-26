---@meta
---@source https://ocdoc.cil.li/api:event

local event_api = {}

--- Register a new event listener that should be called for events with the specified name.
---@param event string name of the signal to listen to.
---@param callback function the function to call if this signal is received. The function will receive the event name it was registered for as first parameter, then all remaining parameters as defined by the signal that caused the event.
---@return number | false # the event id which can be canceled via `event.cancel()`, if the event was successfully registered, `false` if this function was already registered for this event type.
function event_api.listen(event, callback) end

return event_api
