---@meta
---@source https://ocdoc.cil.li/api:process

-- Process API

--- This API provides rudimentary process management.
--- It is used mainly by the `io` module to provide individual standard input and output to individual programs.
--- 
--- It can be helpful to think of a process as a coroutine with extra metadata.
--- A process inherits the metadata of its parent, but can define its own.
--- Such metadata supports stdio and terminal windows.
--- All coroutines created are grouped like child threads of the current process.
--- 
---@class oc.api.process
local process = {}

---@class oc.api.process.info
---@field path string | function
---@field env table<string, any>
---@field command string
---@field data table

--- Loads a Lua script from the specified *absolute* `path` and sets it up as a process.
--- 
--- It will be loaded with a custom environment, to avoid cluttering the callers/global environment.
--- This environment will have access to anything in the specified environment,
--- or the default (top level) environment if none is given.
--- 
--- (since OpenOS 1.6) `path` can also be a `function`, in which case `env` must be `nil`.
--- 
--- If an `init` function is specified, that method is called the first time the resulting coroutine is executed,
--- and run before the actual program is started. This allows fine-tuning of the programs environment.
--- 
--- If a `name` is specified, that is the name the process will specify in `process.running`.
--- It will be `nil` otherwise.
--- 
---@param path string | function
---@param env table?
---@param init function?
---@param name string?
---@return thread
function process.load(path, env, init, name) end

--- Returns a table containing the command and path of the specified process, and some other data.
--- The `level` can optionally be provided to get parent processes.
--- It defaults to `1`, the current program. `2` is the current program's parent (the one that called `process.load` to start the current program) and so on.
--- 
---@param level integer?
---@return oc.api.process.info
---@nodiscard
function process.info(level) end

---@deprecated 1.5+, use `process.info` instead
--- Returns the path to the currently running program (i.e. the last process created via `process.load`).
--- The level can optionally be provided to get parent processes.
--- It defaults to `1`, the current program. `2` is the current program's parent (the one that called `process.load` to start the current program) and so on.
--- 
--- The second returned value is the environment of the process, i.e. the table created for it to use as one.
--- 
--- The third returned value is the 'name' of the process, i.e. the fourth parameter to `process.load`.
--- For programs started via the shell this will ususally be the original command.
--- E.g. for `ls -l`, the first returned value will be `ls`, while this value will be `ls -l`.
--- 
---@param level integer?
---@return string path
---@return table env
---@return string? name
---@nodiscard
function process.running(level) end

return process
