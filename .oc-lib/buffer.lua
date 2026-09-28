---@meta
---@source https://ocdoc.cil.li/api:buffer

-- Buffer Stream Interface

---@class OC.Buffer.IStream
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

---@class OC.Buffer:file*
local buffer_api = {}

---@alias OC.Buffer.Mode
---|>"r"
---| "w"
---| "rw"

--- Creates a new buffered stream, wrapping `stream` with read-write `mode`.
--- `mode` can be readonly (`r` or `nil`), read-write (`rw`), or write-only (`w`).
--- 
--- Read about the stream interface methods required on the `stream` object.
--- 
---@param mode? OC.Buffer.Mode
---@param stream OC.Buffer.IStream
function buffer_api.new(mode, stream) end

return buffer_api
