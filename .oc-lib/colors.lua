---@meta
---@source https://ocdoc.cil.li/api:colors

-- Colors API

--- This "API" serves a global table that allows you to refer to colors by their name,
--- instead of their associated ID/number.
--- 
--- The table serves as a look-up in both directions,
--- so for example `colors.blue` has the value `11`,
--- whereas `colors[11]` has the string value `blue`.
--- 
---@enum oc.api.colors
local colors = {
    white     = 0x00,
    orange    = 0x01,
    magenta   = 0x02,
    lightblue = 0x03,
    yellow    = 0x04,
    lime      = 0x05,
    pink      = 0x06,
    gray      = 0x07,
    silver    = 0x08,
    cyan      = 0x09,
    purple    = 0x0A,
    blue      = 0x0B,
    brown     = 0x0C,
    green     = 0x0D,
    red       = 0x0E,
    black     = 0x0F,

    [0x00]    = "white",
    [0x01]    = "orange",
    [0x02]    = "magenta",
    [0x03]    = "lightblue",
    [0x04]    = "yellow",
    [0x05]    = "lime",
    [0x06]    = "pink",
    [0x07]    = "gray",
    [0x08]    = "silver",
    [0x09]    = "cyan",
    [0x0A]    = "purple",
    [0x0B]    = "blue",
    [0x0C]    = "brown",
    [0x0D]    = "green",
    [0x0E]    = "red",
    [0x0F]    = "black",
}

return colors
