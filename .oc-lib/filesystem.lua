---@meta
---@source https://ocdoc.cil.li/api:filesystem

-- Filesystem API

--- This library allows a general way of interacting with file system components.
--- 
--- While each component is its own “folder”, these folders can be “mounted” somewhere into a global directory tree.
--- This allows seamlessly interacting on multiple file system components.
--- 
--- Not to be confused with the Filesystem component with which this API works.
--- 
---@class oc.api.filesystem
local filesystem = {}

---@alias oc.api.filesystem.label string

--- Returns whether autorun is currently enabled.
--- 
--- If this is `true`, newly mounted file systems will be checked for a file named `autorun[.lua]` in their root directory.
--- If such a file exists, it is executed.
--- 
---@return boolean
---@nodiscard
function filesystem.isAutorunEnabled() end

--- Sets whether autorun files should be ran on startup.
--- 
---@param en boolean
function filesystem.setAutorunEnabled(en) end

--- Returns the canonical form of the specified path, i.e. a path containing no “indirections” such as `.` or `..`.
--- For example, the paths `/tmp/../bin/ls.lua` and `/bin/./ls.lua` are equivalent, and their canonical form is `/bin/ls.lua`.
--- 
--- Note that this function truncates relative paths to their topmost "known" directory.
--- For example, `../bin/ls.lua` becomes `bin/ls.lua`.
--- It stays a relative path, however - mind the lack of a leading slash.
--- 
---@param path string
---@return string
---@nodiscard
function filesystem.canonical(path) end

--- Returns a table containing one entry for each canonical segment of the given path.
--- 
--- Examples:
--- 
---     filesystem.segments("foo/bar") -> {"foo","bar"}
---     filesystem.segments("foo/bar/../baz") -> {"foo","baz"}
--- 
---@param path string
---@return string[]
---@nodiscard
function filesystem.segments(path) end

--- Concatenates two or more paths.
--- 
--- Note that all paths other than the first are treated as relative paths, even if they begin with a slash.
--- The canonical form of the resulting concatenated path is returned, so `fs.concat("a", "..")` results in an empty string.
--- 
---@param ... string
---@return string
---@nodiscard
function filesystem.concat(...) end

--- Returns the path component of a path to a file,
--- i.e. everything before the last slash in the canonical form of the specified path.
--- 
---@param path string
---@returns string
---@nodiscard
function filesystem.path(path) end

--- Returns the file name component of a path to a file,
--- i.e. everything after the last slash in the canonical form of the specified path.
--- 
---@param path string
---@return string
---@nodiscard
function filesystem.name(path) end

--- This is similar to `component.proxy`, except that the specified string may also be a file system component's label.
--- We check for the label first, if no file system has the specified label we fall back to `component.proxy`.
--- 
--- Returns the proxy of the specified file system, or `nil` and an error message if no file system matching the specified filter was found.
--- 
---@param filter string
---@return oc.component.filesystem? fs
---@return string? errmsg
---@nodiscard
function filesystem.proxy(filter) end

--- Mounts a file system at the specified path.
--- 
--- The first parameter can be either a file system component's proxy, its address or its label.
--- The second is a path into the global directory tree.
--- 
--- Returns `true` if the file system was successfully mounted, `nil` and an error message otherwise.
--- 
---@param fs oc.component.filesystem | oc.component.address | oc.api.filesystem.label
---@param path string
---@return boolean? ok
---@return string? errmsg
function filesystem.mount(fs, path) end

--- Returns an iterator function over all currently mounted file system component's proxies and the paths at which they are mounted.
--- This means the same proxy may appear multiple times, but with different mount paths.
--- 
---@return fun(): oc.component.filesystem, string iterator
---@nodiscard
function filesystem.mounts() end

--- Unmounts a file system.
--- 
--- The parameter can either be a file system component's proxy or (abbreviated) address,
--- in which case all mount points of this file system will be removed,
--- or a path into the global directory structure,
--- in which case the file system mount containing that directory will be unmounted.
--- 
---@param fs_path oc.component.filesystem | string
---@return boolean
function filesystem.umount(fs_path) end

--- Checks if the object at the specified path is a symlink, if so returns the path to where it links.
--- 
---@param path string
---@return boolean, string?
---@nodiscard
function filesystem.isLink(path) end

--- Creates a symbolic link to the specified target path at the specified path.
--- 
--- This is a 'soft' link, i.e. it the target file does not actually have to exist at the time of creation,
--- and the link will not be deleted if the target file is deleted.
--- 
--- Symbolic links do not persist across reboots.
--- 
---@param target string
---@param linkpath string
---@return boolean? ok
---@return string? errmsg
function filesystem.link(target, linkpath) end

--- Gets the file system component's proxy that contains the specified path.
--- 
--- Returns the `proxy` and mount path, or `nil` and an error message.
--- 
---@param path string
---@return oc.component.filesystem? fs
---@return string mount_errmsg
---@nodiscard
function filesystem.get(path) end

--- Checks whether a file or folder exist at the specified path.
--- 
---@param path string
---@return boolean
---@nodiscard
function filesystem.exists(path) end

--- Gets the file size of the file at the specified location.
--- 
--- Returns `0` if the path points to anything other than a file.
--- 
---@param path string
---@return number
---@nodiscard
function filesystem.size(path) end

--- Gets whether the path points to a directory.
--- 
--- Returns `false` if not, either because the path points to a file, or `file.exists(path)` is `false`.
--- 
---@param path string
---@return boolean
---@nodiscard
function filesystem.isDirectory(path) end

--- Returns the *real world* unix timestamp of the last time the file at the specified path was modified.
--- For directories this is usually the time of their creation.
--- 
---@param path string
---@return number
---@nodiscard
function filesystem.lastModified(path) end

--- Returns an iterator over all elements in the directory at the specified path.
--- 
--- Returns `nil` and an error messages if the path is invalid or some other error occurred.
--- 
--- Note that directories usually are postfixed with a slash, to allow identifying them without an additional call to `fs.isDirectory`.
--- 
---@param path string
---@return (fun(): string)? iterator
---@return string? errmsg
---@nodiscard
function filesystem.list(path) end

--- Creates a new directory at the specified path.
--- Creates any parent directories that do not exist yet, if necessary.
--- 
--- Returns `true` on success, `nil` and an error message otherwise.
--- 
---@param path string
---@return boolean? ok
---@return string? errmsg
function filesystem.makeDirectory(path) end

--- Deletes a file or folder.
--- If the path specifies a folder, deletes all files and subdirectories in the folder, recursively.
--- 
--- Return `true` on success, `nil` and an error message otherwise.
--- 
---@param path string
---@return boolean? ok
---@return string? errmsg
function filesystem.remove(path) end

--- Renames a file or folder.
--- 
--- If the paths point to different file system components this will only work for files,
--- because it actually perform a copy operation, followed by a deletion if the copy succeeds.
--- 
--- Returns `true` on success, `nil` and an error message otherwise.
--- 
---@param old string
---@param new string
---@return boolean? ok
---@return string? errmsg
function filesystem.rename(old, new) end

--- Copies a file to the specified location.
--- The target path has to contain the target file name.
--- 
--- Does not support folders.
--- 
---@param from string
---@param to string
---@return boolean? ok
---@return string? errmsg
function filesystem.copy(from, to) end

--- Opens a file at the specified path for reading or writing.
--- If mode is not specified it defaults to `r`. Possible modes are: `r`, `rb`, `w`, `wb`, `a` and `ab`.
--- 
--- Returns a file stream on success, `nil` and an error message otherwise.
--- 
--- Note that you can only open a limited number of files per file system at the same time.
--- Files will be automatically closed when the garbage collection kicks in,
--- but it is generally a good idea to call `close` on the file stream when done with the file.
--- 
--- **Important**: it is generally recommended to use `io.open` instead of this function, to get a buffered wrapper for the file stream.
--- 
---@param path string
---@param mode openmode?
---@return file*?
---@return string? errmsg
---@nodiscard
function filesystem.open(path, mode) end

return filesystem
