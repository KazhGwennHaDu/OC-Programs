# kutil - Kazh utilitary

## daemon

## string

string base library extension.

### `split(s, delimiter)`

Splits a string into an array of strings by the delimiter.

- **Parameters**
    1. `string` The string to split.
    2. `string` The delimiter used to split the string.

- **Returns**
    1. `string[]` The split string array.

### `trim(s)`

Trims a string of the spaces.

- **Parameters**
    1. `string` The string to trim.

- **Returns**
    1. `string` The trimed string.

### `ltrim(s)`

Trims a string of the spaces to its left.

- **Parameters**
    1. `string` The string to trim.

- **Returns**
    1. `string` The trimed string.

### `rtrim(s)`

Trims a string of the spaces to its right.

- **Parameters**
    1. `string` The string to trim.

- **Returns**
    1. `string` The trimed string.

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
