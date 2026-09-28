---@meta
---@source https://ocdoc.cil.li/api:component

-- Component API

---@alias OC.Component.Address uuid
---@alias OC.Component.Type string

---@class OC.Component.Proxy
---@field address OC.Component.Address
---@field type OC.Component.Type

---@class OC.Component
local component_api = {}

--- Returns the documentation string for the method with the specified name of the component with the specified address, if any.
--- 
--- Note that you can also get this string by using `tostring` on a method in a proxy, for example `tostring(component.screen.isOn)`.
--- 
---@param address OC.Component.Address
---@param method string
---@return string
function component_api.doc(address, method) end

--- Calls the method with the specified name on the component with the specified address,
--- passing the remaining arguments as arguments to that method. Returns the result of the method call,
--- i.e. the values returned by the method.
--- 
--- Depending on the called method's implementation this may throw.
--- 
---@param address OC.Component.Address
---@param method string
---@param ... any
---@return ...
function component_api.invoke(address, method, ...) end

--- Returns a table with all components currently attached to the computer, with address as a key and component type as a value.
--- It also provides iterator syntax via `__call`, so you can use it like so:
--- `for address, componentType in component.list() do ... end`
--- 
--- If `filter` is set this will only return components that contain the filter string (this is not a pattern/regular expression).
--- For example, `component.list("red")` will return `redstone` components.
--- 
--- If `true` is passed as a second parameter, exact matching is enforced, e.g. `red` will not match `redstone`.
--- 
---@param filter string?
---@param exact boolean?
---@return fun(): OC.Component.Address, OC.Component.Type
function component_api.list(filter, exact) end

--- Returns a table with the names of all methods provided by the component with the specified address.
--- 
--- The names are the keys in the table, the values indicate whether the method is called directly or not.
--- 
---@param address OC.Component.Address
---@return table<string, boolean>
function component_api.methods(address) end

--- Gets a 'proxy' object for a component that provides all methods the component provides as fields,
--- so they can be called more directly (instead of via `invoke`).
--- This is what's used to generate 'primaries' of the individual component types, i.e. what you get via `component.blah`.
--- 
--- For example, you can use it like so: `component.proxy(component.list("redstone")()).getInput(sides.north)`,
--- which gets you a proxy for the first `redstone` component returned by the `component.list` iterator, and then calls `getInput` on it.
--- 
--- Note that proxies will always have at least two fields, `type` with the component's type name, and `address` with the component's address.
--- 
---@param address OC.Component.Address
---@return OC.Component.Proxy
function component_api.proxy(address) end

--- Get the component type of the component with the specified address.
--- 
---@param address OC.Component.Address
---@return OC.Component.Type
function component_api.type(address) end

--- Return slot number which the component is installed into.
--- Returns -1 if it doesn't otherwise make sense.
--- 
---@param address OC.Component.Address
---@return integer
function component_api.slot(address) end

--- Undocumented
--- 
---@param address OC.Component.Address
---@return string[]
function component_api.fields(address) end

--- Tries to resolve an abbreviated address to a full address.
--- Returns the full address on success, or `nil` and an error message otherwise.
--- Optionally filters by component type.
--- 
---@param address OC.Component.Address
---@param component_type OC.Component.Type?
---@return OC.Component.Address? address
---@return string? reason
function component_api.get(address, component_type) end

--- Checks if there is a primary component of the specified component type.
--- 
---@param component_type OC.Component.Type
---@return boolean
function component_api.isAvailable(component_type) end

--- Gets the proxy for the primary component of the specified type.
--- Throws an error if there is no primary component of the specified type.
--- 
---@param component_type OC.Component.Type
---@return OC.Component.Proxy
function component_api.getPrimary(component_type) end

--- Sets a new primary component for the specified component type.
--- The address may be abbreviated, but must be valid if it is not `nil`.
--- Triggers the `component_unavailable` and `component_available` signals if set to `nil` or a new value, respectively.
--- 
---@param component_type OC.Component.Type
---@param address OC.Component.Address
function component_api.setPrimary(component_type, address) end

return component_api
