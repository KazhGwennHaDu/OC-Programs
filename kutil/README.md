# kutil - Kazh utilitary

## daemon

## uuid

uuid base library extension.

> [!note]
> A uuid is a 128 bits identifier, represented as a hex value in a string grouped by 8, 4, 4, 4, and 12 hex characters, separated by dashes.
> e.g. `34eb7b28-14d3-4767-b326-dd1609ba92ef`

### `next()`

[`uuid.next()`](https://ocdoc.cil.li/api:uuid) passthrough from OC's base libraries.

- **Returns**
    1. `string` A random uuid.

### `find(str)`

Finds and extracts the uuid of a string.

- **Parameters**
    1. `string` The string to extract the uuid from.

- **Returns**
    1. `string` | `nil` The uuid.

### `check(str)`

Checks that the provided string as a uuid.

- **Parameters**
    1. `string` The uuid to check.

- **Returns**
    1. `boolean`
