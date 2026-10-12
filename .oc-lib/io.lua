---@meta
---@source https://ocdoc.cil.li/api:non-standard-lua-libs#input_and_output_facilities

---Sets `file` as the default error file.
---
---@overload fun():file*
---@param file string|file*
function io.error(file) end

---Sets `file` as the default `n` stream file.
---
---@overload fun(n: integer):file*
---@param n integer
---@param file string|file*
function io.stream(n, file) end
