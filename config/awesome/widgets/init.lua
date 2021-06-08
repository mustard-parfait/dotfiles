local awful		= require('awful')
local beautiful	= require('beautiful')
local gears		= require('gears')
local wibox		= require('wibox')
local helpers	= require('helpers')
local awestore	= require('modules.awestore')

local dpi		= require('beautiful').xresources.apply_dpi
local start		= require('widgets.popdown')
local down      = require('widgets.shutdown')
local boot      = require('widgets.rebootpop')
local ll        = require('widgets.laylist')
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

start.x = -100
start.y = 300

local panel_anim = awestore.tweened(-101, {
    duration = 350,
    easing = awestore.easing.circ_in_out
})

local strut_anim = awestore.tweened(0, {
    duration = 300,
    easing = awestore.easing.circ_in_out
})

panel_anim:subscribe(function(x) start.x = x end)
strut_anim:subscribe(function(width)
    start:struts{left = width, right = 0, bottom = 0, top = 0}
end)

awesome.connect_signal("widgets::start::toggle", function()
    if not start.visible then
        start.visible = true
        strut_anim:set(101)
        panel_anim:set(-1 * beautiful.widget_border_width)
    else
        strut_anim:set(0)
        panel_anim:set(-451)
        local unsub_strut
        unsub_strut = strut_anim.ended:subscribe(function() unsub_strut() end)
        local unsub_panel
        unsub_panel = panel_anim.ended:subscribe(
                          function()
                start.visible = false
                unsub_panel()
            end)
    end

    awesome.emit_signal("widgets::start::status", start.visible)
end)

down.x = -200
down.y = 40

local shutdown_anim = awestore.tweened(-201, {
    duration = 350,
    easing = awestore.easing.circ_in_out
})

local down_strut_anim = awestore.tweened(0, {
    duration = 300,
    easing = awestore.easing.circ_in_out
})

shutdown_anim:subscribe(function(x) down.x = x end)
down_strut_anim:subscribe(function(width)
    down:struts{left = width, right = 0, bottom = 0, top = 0}
end)

awesome.connect_signal("widgets::down::toggle", function()
    if not down.visible then
        down.visible = true
        boot.visible = false
        ll.visible = false
        down_strut_anim:set(201)
        shutdown_anim:set(-1 * beautiful.widget_border_width)
    else
        down_strut_anim:set(0)
        shutdown_anim:set(-201)
        local unsub_strut
        unsub_strut = down_strut_anim.ended:subscribe(function() unsub_strut() end)
        local unsub_panel
        unsub_panel = shutdown_anim.ended:subscribe(
                          function()
                down.visible = false
                unsub_panel()
            end)
    end

    awesome.emit_signal("widgets::down::status", down.visible)
end)

boot.x = -200
boot.y = 40

local reboot_anim = awestore.tweened(-201, {
    duration = 350,
    easing = awestore.easing.circ_in_out
})

local boot_strut_anim = awestore.tweened(0, {
    duration = 300,
    easing = awestore.easing.circ_in_out
})

reboot_anim:subscribe(function(x) boot.x = x end)
boot_strut_anim:subscribe(function(width)
    boot:struts{left = width, right = 0, bottom = 0, top = 0}
end)

awesome.connect_signal("widgets::boot::toggle", function()
    if not boot.visible then
        boot.visible = true
        down.visible = false
        ll.visible = false
        boot_strut_anim:set(201)
        reboot_anim:set(-1 * beautiful.widget_border_width)
    else
        boot_strut_anim:set(0)
        reboot_anim:set(-201)
        local unsub_strut
        unsub_strut = down_strut_anim.ended:subscribe(function() unsub_strut() end)
        local unsub_panel
        unsub_panel = reboot_anim.ended:subscribe(
                          function()
                boot.visible = false
                unsub_panel()
            end)
    end

    awesome.emit_signal("widgets::boot::status", boot.visible)
end)

ll.x = -280
ll.y = 40

local ll_anim = awestore.tweened(-281, {
    duration = 350,
    easing = awestore.easing.circ_in_out
})

local ll_strut_anim = awestore.tweened(0, {
    duration = 300,
    easing = awestore.easing.circ_in_out
})

ll_anim:subscribe(function(x) ll.x = x end)
ll_strut_anim:subscribe(function(width)
    ll:struts{left = width, right = 0, bottom = 0, top = 0}
end)

awesome.connect_signal("widgets::ll::toggle", function()
    if not ll.visible then
        boot.visible = false
        down.visible = false
        ll.visible = true
        ll_strut_anim:set(281)
        ll_anim:set(-1 * beautiful.widget_border_width)
    else
        ll_strut_anim:set(0)
        ll_anim:set(-281)
        local unsub_strut
        unsub_strut = ll_strut_anim.ended:subscribe(function() unsub_strut() end)
        local unsub_panel
        unsub_panel = ll_anim.ended:subscribe(
                          function()
                ll.visible = false
                unsub_panel()
            end)
    end

    awesome.emit_signal("widgets:ll::status", ll.visible)
end)
