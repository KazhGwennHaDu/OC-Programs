# DNKazh

## `getPort()`

Returns the port used by the API, default is `53`.

+ ### Returns

    1. `number`

## `setPort(_port)`

Sets the port used by the API, default is `53`

+ ### Parameters

    1. `number`

## `getHost()`

Returns the address of the DNS server, default is `nil`.

+ ### Returns

    1. `uuid`

## `setHost(_port)`

Sets the address of the DNS server, default is `nil`.

+ ### Parameters

    1. `uuid`

## `whodns()`

Requests the address of the DNS server via broadcast.

+ ### Returns

    1. `uuid` | `nil` The address of the server.

## `register(_name[, _addr])`

Registers a domaine to the DNS server.

+ ### Parameters

    1. _name : `string` The name of the domaine to register.
    2. _addr? : `uuid` The address of a computer, if not provided the local computer address will be used.

+ ### Returns

    1. `boolean` Success of the registration.
    2. `string` | `nil` Reason of failure.
