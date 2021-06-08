local awestore = require("modules.awestore")
local bling = require("bling")
local dpi   = require("beautiful.xresources").apply_dpi

local kitty_anim_x = awestore.tweened(-100, {
    duration = 500,
    easing = awestore.easing.cubic_in_out
})

local kitty_anim_y = awestore.tweened(2080, {
        duration = 500,
        easing = awestore.easing.cubic_in_out
    })

local kitty_scratchpad = bling.module.scratchpad:new {
    command = "kitty --class kitty_scratch",
    rule = { instance = "kitty_scratch" },
    sticky = false,
    floating = true,
    geometry = {x = dpi(1140), y = dpi(530), height = dpi(540), width = dpi(770)},
    reapply = true,
    awestore = {y = kitty_anim_y}
}

return kitty_scratchpad
