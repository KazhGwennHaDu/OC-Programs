---@meta _
---@source https://ocdoc.cil.li/component:filesystem

---@class oc.component.filesystem:oc.component.proxy
local filesystem = { type = "filesystem" }

--- The currently used capacity of the file system, in bytes.
--- 
---@return integer
---@nodiscard
function filesystem.spaceUsed() end

--- The overall capacity of the file system, in bytes.
--- 
---@return integer
---@nodiscard
function filesystem.spaceTotal() end

--- Returns whether the file system is read-only.
--- 
---@return boolean
---@nodiscard
function filesystem.isReadOnly() end

--- Get the current label of the file system.
--- 
---@return string
---@nodiscard
function filesystem.getLabel() end

--- Sets the label of the file system.
--- Returns the new value, which may be truncated.
--- 
---@param value string
---@return string
function filesystem.setLabel(value) end

--- Returns whether an object exists at the specified absolute path in the file system.
--- 
---@param path string
---@return boolean
---@nodiscard
function filesystem.exists(path) end

--- Returns the (real world) timestamp of when the object at the specified absolute path in the file system was modified.
--- 
---@param path string
---@return integer
---@nodiscard
function filesystem.lastModified(path) end

--- Returns the size of the object at the specified absolute path in the file system.
--- 
---@param path string
---@return integer
---@nodiscard
function filesystem.size(path) end

--- Returns a list of names of objects in the directory at the specified absolute path in the file system.
--- 
---@param path string
---@return string[]
---@nodiscard
function filesystem.list(path) end

--- Returns whether the object at the specified absolute path in the file system is a directory.
--- 
---@param path string
---@return boolean
---@nodiscard
function filesystem.isDirectory(path) end

--- Creates a directory at the specified absolute path in the file system.
--- Creates parent directories, if necessary.
--- 
---@param path string
---@return boolean
function filesystem.makeDirectory(path) end

--- Removes the object at the specified absolute path in the file system.
--- 
---@param path string
---@return boolean
function filesystem.remove(path) end

--- Renames/moves an object from the first specified absolute path in the file system to the second.
--- 
---@param from string
---@param to string
---@return boolean
function filesystem.rename(from, to) end

-- FILE

--- Opens a new file descriptor and returns its handle.
--- 
---@param path string
---@param mode openmode
---@return userdata
---@nodiscard
function filesystem.open(path, mode) end

--- Closes an open file descriptor with the specified handle.
--- 
---@param handle userdata
function filesystem.close(handle) end

--- Reads up to the specified amount of data from an open file descriptor with the specified handle.
--- Returns nil when EOF is reached.
--- 
---@param handle userdata
---@param count integer
---@return string | nil
---@nodiscard
function filesystem.read(handle, count) end

--- Writes the specified data to an open file descriptor with the specified handle.
--- 
---@param handle userdata
---@param value string
---@return boolean
function filesystem.write(handle, value) end

--- Seeks in an open file descriptor with the specified handle. Returns the new pointer position.
--- 
---@param handle userdata
---@param whence seekwhence
---@param offset integer
---@return integer
function filesystem.seek(handle, whence, offset) end
