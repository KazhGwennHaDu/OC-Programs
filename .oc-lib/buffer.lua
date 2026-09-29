---@meta
---@source https://ocdoc.cil.li/api:buffer

-- Buffer Stream Interface

--- The following methods can only be called on instances created by `buffer.new`
--- (note file handles returned by `io.open` are also buffered streams, created with `buffer.new`).
--- These methods are instance methods, requiring instance call notation `:`.
--- 
--- In order to help differentiate these instance methods from static methods (e.g. `buffer.new`),
--- `b:` will be used to prefix the method names.
--- 
---@class oc.api.buffer.istream
local istream = {}

--- Return `n` bytes, and **not** `n` unicode-aware chars.
--- Assume your data is binary data and let the buffer library manage the mode and the unicode string packaging (if applicable).
--- 
--- Note that this is exactly how the filesystem library operates.
--- The caller assumes there is more data to read until `nil` is returned.
--- An empty string or a string shorter than `n` chars long is a valid return,
--- but the caller may assume there is more data to request until `nil` is returned.
--- 
---@param n integer
---@return string? result
---@return string? reason
function istream:read(n) end

--- Write `s` as bytes, assume a string of plain unformatted chars.
--- Return falsey and reason on failure.
--- 
---@param s string
---@return integer? n
---@return string? reason
function istream:write(s) end

--- Refer to `b:seek()` for details.
---
--- In short, move the stream position to `offset` from `whence`, and return the `offset` from the start of the stream of the position after the seek operation.
--- 
--- Note that `seek("cur", 0)` is a valid request, typical of the caller wanting to determine the current position of the stream.
--- Your stream is not required to support seek, in such case (or in any case of failure) you should return nil,
--- and the reason (as a string) for the failure.
--- 
---@param whence? seekwhence
---@param offset? integer
---@return integer? offset
---@return string? errmsg
function istream:seek(whence, offset) end

--- Close handles, release resources, disconnect – and return success.
--- 
---@return boolean ok
---@return string? reason
function istream:close() end

-- Buffer API

--- The `buffer` library provides user friendly streams.
--- These are the kind that the `io` library returns from `io.open`
--- unlike the raw streams returned by `filesystem.open` which don't support as many helpful methods.
--- These helper methods on the file handles you get from `io.open` are defined here, under Instance Methods.
--- Thus, this API documentation is important and helpful even if you aren't building your own buffered streams.
--- 
--- Additionally, this API allows you to create buffered streams.
--- You provide the backend stream read and write, the buffer library provides the formatting and buffering of the data.
--- Generally, users will not need to make their own buffered streams.
--- For reference, the io library uses buffered streams (which includes file io as well as terminal io).
--- 
---@class oc.api.buffer:file*
local buffer = {}

---@alias oc.api.buffer.mode
---|>"r"
---| "w"
---| "rw"

--- Creates a new buffered stream, wrapping `stream` with read-write `mode`.
--- `mode` can be readonly (`r` or `nil`), read-write (`rw`), or write-only (`w`).
--- 
--- Read about the stream interface methods required on the `stream` object.
--- 
---@param mode? oc.api.buffer.mode
---@param stream oc.api.buffer.istream
---@nodiscard
function buffer.new(mode, stream) end

return buffer
