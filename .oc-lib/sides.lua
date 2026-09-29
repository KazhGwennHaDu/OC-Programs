---@meta
---@source https://ocdoc.cil.li/api:sides

-- Sides API

--- This "API" provides a global table to allow you to refer to sides / directions by name, as opposed to their numbers.
--- The underlying number values are identical to Minecraft's internal numbering (as well as the `ForgeDirection Enum`).
--- 
--- This table serves as a two-directional look-up, so you can resolve names to numbers,
--- but also numbers back to a human readable name.
--- For example, `sides.top` has the value `1, whereas `sides[1]` has the string value `top`.
--- 
--- A couple of aliases for the side names are available, so it's less likely to accidentally pick the wrong one.
--- 
---@enum oc.api.sides
local sides = {
    bottom  = 0x00,
    top     = 0x01,
    back    = 0x02,
    front   = 0x03,
    right   = 0x04,
    left    = 0x05,

    down    = 0x00,
    up      = 0x01,
    north   = 0x02,
    south   = 0x03,
    west    = 0x04,
    east    = 0x05,

    negy    = 0x00,
    posy    = 0x01,
    negz    = 0x02,
    posz    = 0x03,
    negx    = 0x04,
    posx    = 0x05,

    forward = 0x03,

    [0x00]  = "bottom",
    [0x01]  = "top",
    [0x02]  = "back",
    [0x03]  = "front",
    [0x04]  = "right",
    [0x05]  = "left",
}

return sides
