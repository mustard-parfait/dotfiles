local awful		= require('awful')
local beautiful	= require('beautiful')
local gears		= require('gears')
local wibox		= require('wibox')
local helpers	= require('helpers')
local awestore	= require('modules.awestore')

local dpi		= require('beautiful').xresources.apply_dpi
local slide		= require('widgets.slider.slide')
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

slide.x = -380
slide.y = 0

local panel_anim = awestore.tweened(-395, {
    duration = 350,
    easing = awestore.easing.circ_in_out
})

local strut_anim = awestore.tweened(0, {
    duration = 300,
    easing = awestore.easing.circ_in_out
})

panel_anim:subscribe(function(x) slide.x = x end)
strut_anim:subscribe(function(width)
    slide:struts{left = width, right = 0, bottom = 0, top = 0}
end)

awesome.connect_signal("widgets::slide::toggle", function()
    if not slide.visible then
        slide.visible = true
        strut_anim:set(395)
        panel_anim:set(-1 * beautiful.widget_border_width)
    else
        strut_anim:set(0)
        panel_anim:set(-395)
        local unsub_strut
        unsub_strut = strut_anim.ended:subscribe(function() unsub_strut() end)
        local unsub_panel
        unsub_panel = panel_anim.ended:subscribe(
                          function()
                slide.visible = false
                unsub_panel()
            end)
    end

    awesome.emit_signal("widgets::slide::status", slide.visible)
end)
