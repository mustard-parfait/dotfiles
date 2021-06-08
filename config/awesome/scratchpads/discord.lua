local awestore = require("modules.awestore")
local bling = require("bling")
local dpi   = require("beautiful.xresources").apply_dpi

local discord_anim_x = awestore.tweened(1440, {
    duration = 500,
    easing = awestore.easing.cubic_in_out
})

local discord_anim_y = awestore.tweened(5120, {
        duration = 500,
        easing = awestore.easing.cubic_in_out
    })

local discord_scratchpad = bling.module.scratchpad:new {
    command = "discord-ptd",
    rule = { instance = "discord" },
    sticky = false,
    floating = true,
    geometry = {x = dpi(250), y = dpi(90), height = dpi(880), width = dpi(1440)},
    reapply = true,
    awestore = {x = discord_anim_x, y = discord_anim_y}
}

return discord_scratchpad
