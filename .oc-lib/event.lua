---@meta
---@source https://ocdoc.cil.li/api:event

-- Event API

---@class OC.Event
local event_api = {}

---@alias OC.Event.Type string

--- Note: An event listeners may return `false` to unregister themselves,
--- which is equivalent to calling `event.ignore` and passing the listener with the event name it was registered for.
---@alias OC.Event.Callback fun(event: OC.Event.Type, ...: any): boolean?

--- Register a new event listener that should be called for events with the specified name.
--- 
---@param event OC.Event.Type name of the signal to listen to.
---@param callback OC.Event.Callback the function to call if this signal is received. The function will receive the event name it was registered for as first parameter, then all remaining parameters as defined by the signal that caused the event.
---@return integer | false # the event id which can be canceled via `event.cancel()`, if the event was successfully registered, `false` if this function was already registered for this event type.
function event_api.listen(event, callback) end

--- Unregister a previously registered event listener.
--- 
---@param event OC.Event.Type name of the signal to unregister.
---@param callback OC.Event.Callback the function that was used to register for this event.
---@return boolean # `true` if the event was successfully unregistered, `false` if this function was not registered for this event type.
function event_api.ignore(event, callback) end

--- Starts a new timer that will be called after the time specified in `interval`.
--- 
--- Note: the timer resolution can vary. If the computer is idle and enters sleep mode, it will only be woken in a game tick,
--- so the time the callback is called may be up to 0.05 seconds off.
--- 
---@param interval number time in seconds between each invocation of the callback function. Can be a fraction like 0.05.
---@param callback OC.Event.Callback the function to call.
---@param times integer? how many times the function will be called. If omitted the function will be called once. Pass `math.huge` for infinite repeat.
---@return integer # a timer ID that can be used to cancel the timer at any time.
function event_api.timer(interval, callback, times) end

--- Cancels a timer previously created with `event.timer`.
--- 
---@param timer_id integer a timer ID as returned by event.timer.
---@return boolean # `true` if the timer was stopped, `false` if there was no timer with the specified ID.
function event_api.cancel(timer_id) end

--- Pulls and returns the next available event from the queue, or waits until one becomes available.
--- 
---@param timeout number? if passed the function will wait for a new event for this many seconds at maximum then returns `nil` if no event was queued during that time.
---@param event OC.Event.Type? an event pattern that will act as a filter. If given then only events that match this pattern will be returned. Can be `nil` in which case the event names will not be filtered. See `string.match` on how to use patterns.
---@param ... any any number of parameters in the same order as defined by the signal that is expected. Those arguments will act as filters for the additional arguments returned by the signal. Direct equality is used to determine if the argument is equal to the given filter. Can be `nil` in which case this particular argument will not be filtered.
---@return OC.Event.Type event
---@return any ...
function event_api.pull(timeout, event, ...) end

--- Pulls and returns the next available event from the queue, or waits until one becomes available but allows filtering by specifying filter function.
--- 
---@param timeout number? if passed the function will wait for a new event for this many seconds at maximum then returns `nil` if no event was queued during that time.
---@param filter fun(event: OC.Event.Type, ...: any): boolean if passed the function will use it as a filtering function of events. Allows for advanced filtering.
---@return OC.Event.Type event
---@return any ...
function event_api.pullFiltered(timeout, filter) end

--- As its arguments `pullMultiple` accepts multiple event names to be pulled, allowing basic filtering of multiple events at once.
--- 
---@param ... OC.Event.Type
---@return OC.Event.Type event
---@return any ...
function event_api.pullMultiple(...) end

--- Global event callback error handler.
--- If an event listener throws an error, we handle it in this function to avoid it bubbling into unrelated code (that only triggered the execution by calling `event.pull`).
--- Per default, this logs errors into a file on the temporary file system.
--- 
--- You can replace this function with your own if you want to handle event errors in a different way.
--- 
---@param message any
function event_api.onError(message) end

---This is only an alias to computer.pushSignal.
---This does not modify the arguments in any way.
---It seemed logical to add the alias to the event library because there is also an `event.pull` for signals.
---
---@param event OC.Event.Type
---@param ... any
function event_api.push(event, ...) end

--[[ Interrupts

Starting In OpenOS 1.6.4 and later, interrupts have been cleaned up. The following two methods are now obsolete

    event.shouldSoftInterrupt(): boolean (Since 1.5.9 and removed in )
    event.shouldInterrupt(): boolean (Since 1.5.9 and removed in 1.6.4)

Interrupts are a type of messaging intended to close or stop a process. In OpenOS the computer.pullSignal(), and thus any wrapper, generates 2 types of events.

They are especially useful when event.pull*() is called without time limit and with a filter. In some cases this means that event.pull*() could be waiting indefinitely.

    Soft interrupts are an event signal generated by pressing Ctrl+C. The signal returns two fields, the event name "interrupted" and the computer uptime
    Hard interrupts are generated by pressing Ctrl-Alt-C. It forcibly exits the event.pull*() method by throwing a "interrupted" error.
]]

---@deprecated 1.6.4+
--- Soft interrupts are an event signal generated by pressing Ctrl+C. The signal returns two fields, the event name "interrupted" and the computer uptime.
--- 
---@return boolean
---@nodiscard
function event_api.shouldSoftInterrupt() end

---@deprecated 1.6.4+
--- Hard interrupts are generated by pressing Ctrl-Alt-C. It forcibly exits the event.pull*() method by throwing a "interrupted" error.
--- 
---@return boolean
---@nodiscard
function event_api.shouldInterrupt() end

return event_api
