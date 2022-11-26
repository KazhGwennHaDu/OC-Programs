# DNKazh

## `getPort()`

Returns the port used by the API, default is `53`.

+ ### Returns

    1. `number`

## `setPort(_port)`

Sets the port used by the API, default is `53`

+ ### Parameters

    1. _port : `number`

+ ### Returns

    1. `boolean` Success of the operation.

## `getHost()`

Returns the address of the DNS server, default is `nil`.

+ ### Returns

    1. `uuid`

## `setHost(_addr)`

Sets the address of the DNS server, default is `nil`.

+ ### Parameters

    1. _addr : `uuid`

+ ### Returns

    1. `boolean` Success of the operation.

## `whodns()`

Requests the address of the DNS server via broadcast.

Returns `nil` if the request times out.

+ ### Returns

    1. `uuid` | `nil` The address of the server.

## `autoSetHost()`

Sets the address of the DNS server via `whodns()`.

+ ### Returns

    1. `boolean` Success of the operation.

## `register(_name[, _addr])`

Registers a domaine to the DNS server.

+ ### Parameters

    1. _name : `string` The name of the domaine to register.
    2. _addr? : `uuid` The address of a computer, if not provided the local computer address will be used.

+ ### Returns

    1. `boolean` Success of the registration.
    2. `string` | `nil` Reason of failure.

## `unregister(_name)`

Unregisters a domaine from the DNS server.

+ ### Parameters

    1. _name : `string` The name of the domaine to unregister.

+ ### Returns

    1. `boolean` Success of the unregistration.
    2. `string` | `nil` Reason of failure.

## `runregister(_addr)`

Unregisters a domaine from the DNS server via the address of the computer.

+ ### Parameters

    1. _addr : `uuid` The address of a computer to unregister.

+ ### Returns

    1. `boolean` Success of the unregistration.
    2. `string` | `nil` Reason of failure.

## `lookup(_name)`

Asks the DNS server the address of the given domaine.

+ ### Parameters

    1. _name : `string` The name of the domaine to lookup.

+ ### Returns

    1. `boolean` Success of the lookup.
    2. `string` | `nil` The domaine or the reason of failure.

## `rlookup(_addr)`

Asks the DNS server the domaine of the given address.

+ ### Parameters

    1. _addr : `uuid` The address of a computer to lookup.

+ ### Returns

    1. `boolean` Success of the lookup.
    2. `uuid` | `string` | `nil` The address or the reason of failure.
