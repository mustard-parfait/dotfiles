local awestore = require("modules.awestore")
local bling = require("bling")
local dpi   = require("beautiful.xresources").apply_dpi

local spotify_anim_x = awestore.tweened(-1080, {
    duration = 500,
    easing = awestore.easing.cubic_in_out
})

local spotify_anim_y = awestore.tweened(1920, {
        duration = 500,
        easing = awestore.easing.cubic_in_out
    })

local spotify_scratchpad = bling.module.scratchpad:new {
    command = "spotify --no-zygote",
    rule = { instance = "spotify" },
    sticky = false,
    floating = true,
    geometry = {x = dpi(10), y = dpi(350), height = dpi(720), width = dpi(960)},
    reapply = true,
    dont_focus_before_close = false,
    awestore = {x = spotify_anim_x}
}

return spotify_scratchpad
