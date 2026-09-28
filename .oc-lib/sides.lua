---@meta
---@source https://ocdoc.cil.li/api:sides

---@enum OC.Sides
local sides_api = {
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

return sides_api
