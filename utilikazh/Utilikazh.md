# UtiliKazh

Utility functions I use in my programs.

## error

### `fail(_err)`

Display a custom error message, makes a beep and exits the current program.

+ ### Parameters

    1. _err : `string` The message to display.

### `notice(_err)`

Display a custom error message and makes a beep.

+ ### Parameters

    1. _err : `string` The message to display.

## serial

### `encode(_data)`

Works like [`serialization.serialize()`](https://ocdoc.cil.li/api:serialization) but protected.

+ ### Parameters

    1. _data : `any` The data to encode.

+ ### Returns
    1. `boolean` Success of the operation.
    2. `string` The encoded data.

### `decode(_data)`

Works like [`serialization.unserialize()`](https://ocdoc.cil.li/api:serialization) but protected.

+ ### Parameters

    1. _data : `string` The data to decode.

+ ### Returns
    1. `boolean` Success of the operation.
    2. `any` The decoded data.

## uuid

uuid's are 128 bit identifiers, represented as a hex value in a string grouped by 8, 4, 4, 4, and 12 hex characters, separated by dashes.

e.g. `34eb7b28-14d3-4767-b326-dd1609ba92ef`

### `next()`

Same as the [`uuid.next()`](https://ocdoc.cil.li/api:uuid) from the OC API.

+ ### Returns
    1. `string` A random uuid.

### `getuuid(_str)`

Extracts the uuid of a string.

+ ### Parameters

    1. `string` The string to extract the uuid from.

+ ### Returns
    1. `string` | `nil` The uuid.

### `isuuid(_str)`

Verify the provided string as a uuid.

+ ### Parameters

    1. `string` The uuid to verify.

+ ### Returns
    1. `boolean`

## Misc

### `version()`

Returns the version of the library.

+ ### Returns
    1. `number` The version of the library.
