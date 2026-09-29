---@meta
---@source https://ocdoc.cil.li/api:event

-- Event API

--- The Event API provides a basic event system to allow your code to react to signals sent by the OS or other programs/libraries.
--- 
--- For example, this can be used to capture keys pressed,
--- react if an external screen is attached or removed,
--- or handle incoming network messages.
--- 
--- **Overview**
--- 
--- There are two main use cases for the event API:
--- 
--- - Have your program react on events while running in the background (driver mode).
--- - Have your program handle events while being the foreground program executed (primary mode).
--- 
--- In driver mode your program needs to register callbacks for events (`using event.listen()`)
--- then it should exit to return execution to the primary program (usually the shell).
--- 
--- In primary mode your program does not need to register events,
--- it can handle them directly using `event.pull()`.
--- 
--- Note: While it is technically possible to do both at the same time it is not recommended to do so.
--- To make sure that events are received by all registered functions,
--- they are consumed only after all functions have been called.
--- So if you register your handler and pull at the same time, you would receive events twice.
--- 
---@class oc.api.event
local event = {}

---@alias oc.api.event.type string

--- Note: An event listeners may return `false` to unregister themselves,
--- which is equivalent to calling `event.ignore` and passing the listener with the event name it was registered for.
---@alias oc.api.event.callback fun(evt: oc.api.event.type, ...: any): boolean?

--- Register a new event listener that should be called for events with the specified name.
--- 
---@param evt oc.api.event.type name of the signal to listen to.
---@param callback oc.api.event.callback the function to call if this signal is received. The function will receive the event name it was registered for as first parameter, then all remaining parameters as defined by the signal that caused the event.
---@return integer | false # the event id which can be canceled via `event.cancel()`, if the event was successfully registered, `false` if this function was already registered for this event type.
function event.listen(evt, callback) end

--- Unregister a previously registered event listener.
--- 
---@param evt oc.api.event.type name of the signal to unregister.
---@param callback oc.api.event.callback the function that was used to register for this event.
---@return boolean # `true` if the event was successfully unregistered, `false` if this function was not registered for this event type.
function event.ignore(evt, callback) end

--- Starts a new timer that will be called after the time specified in `interval`.
--- 
--- Note: the timer resolution can vary. If the computer is idle and enters sleep mode, it will only be woken in a game tick,
--- so the time the callback is called may be up to 0.05 seconds off.
--- 
---@param interval number time in seconds between each invocation of the callback function. Can be a fraction like 0.05.
---@param callback oc.api.event.callback the function to call.
---@param times integer? how many times the function will be called. If omitted the function will be called once. Pass `math.huge` for infinite repeat.
---@return integer # a timer ID that can be used to cancel the timer at any time.
function event.timer(interval, callback, times) end

--- Cancels a timer previously created with `event.timer`.
--- 
---@param timer_id integer a timer ID as returned by event.timer.
---@return boolean # `true` if the timer was stopped, `false` if there was no timer with the specified ID.
function event.cancel(timer_id) end

--- Pulls and returns the next available event from the queue, or waits until one becomes available.
--- 
---@param timeout number? if passed the function will wait for a new event for this many seconds at maximum then returns `nil` if no event was queued during that time.
---@param evt oc.api.event.type? an event pattern that will act as a filter. If given then only events that match this pattern will be returned. Can be `nil` in which case the event names will not be filtered. See `string.match` on how to use patterns.
---@param ... any any number of parameters in the same order as defined by the signal that is expected. Those arguments will act as filters for the additional arguments returned by the signal. Direct equality is used to determine if the argument is equal to the given filter. Can be `nil` in which case this particular argument will not be filtered.
---@return oc.api.event.type evt
---@return any ...
function event.pull(timeout, evt, ...) end

--- Pulls and returns the next available event from the queue, or waits until one becomes available but allows filtering by specifying filter function.
--- 
---@param timeout number? if passed the function will wait for a new event for this many seconds at maximum then returns `nil` if no event was queued during that time.
---@param filter fun(evt: oc.api.event.type, ...: any): boolean if passed the function will use it as a filtering function of events. Allows for advanced filtering.
---@return oc.api.event.type evt
---@return any ...
function event.pullFiltered(timeout, filter) end

--- As its arguments `pullMultiple` accepts multiple event names to be pulled, allowing basic filtering of multiple events at once.
--- 
---@param ... oc.api.event.type
---@return oc.api.event.type evt
---@return any ...
function event.pullMultiple(...) end

--- Global event callback error handler.
--- If an event listener throws an error, we handle it in this function to avoid it bubbling into unrelated code (that only triggered the execution by calling `event.pull`).
--- Per default, this logs errors into a file on the temporary file system.
--- 
--- You can replace this function with your own if you want to handle event errors in a different way.
--- 
---@param message any
function event.onError(message) end

---This is only an alias to computer.pushSignal.
---This does not modify the arguments in any way.
---It seemed logical to add the alias to the event library because there is also an `event.pull` for signals.
---
---@param evt oc.api.event.type
---@param ... any
function event.push(evt, ...) end

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
function event.shouldSoftInterrupt() end

---@deprecated 1.6.4+
--- Hard interrupts are generated by pressing Ctrl-Alt-C. It forcibly exits the event.pull*() method by throwing a "interrupted" error.
--- 
---@return boolean
---@nodiscard
function event.shouldInterrupt() end

return event
