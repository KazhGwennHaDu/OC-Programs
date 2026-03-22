-- LIBRARIES

local fs    = require "filesystem"
local shell = require "shell"
local term  = require "term"

-- SETUP

if not term.isAvailable() then
  return
end

local gpu = term.gpu()
local args, option = shell.parse(...)
if #args == 0 then
  print([[Usage: kedit [OPTIONS] <filename>

  -r | --read_only : Open the file in read only mode.]])
  return
end

term.clear()
term.setCursorBlink(true)

local running = true

-- FUNCTIONS


-- PROGRAM LOOP

while running do
  os.sleep()
end

-- EXIT

term.clear()