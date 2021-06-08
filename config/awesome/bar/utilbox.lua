local awful		= require('awful')
local wibox		= require('wibox')
local beautiful = require('beautiful')
local gears		= require('gears')
local helpers = require("helpers")

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local power_button = wibox.widget {
	{
		{
			font = beautiful.icon_font,
			text = "",
			widget = wibox.widget.textbox
		},
		left = dpi(3),
		right = dpi(3),
		widget = wibox.container.margin
	},
	bg = beautiful.xbackground,
	fg = "#D6D8DC",
	shape = helpers.rrect(beautiful.border_radius - 3),
	widget = wibox.container.background
}

local reboot_button = wibox.widget {
	{
		{
			font = beautiful.icon_font,
			text = "",
			widget = wibox.widget.textbox
		},
		left = dpi(3),
		right = dpi(3),
		widget = wibox.container.margin
	},
	bg = beautiful.xbackground,
	fg = "#D6D8DC",
	shape = helpers.rrect(beautiful.border_radius - 3),
	widget = wibox.container.background
}

local lay_rrent = wibox.widget {
	{
		{
			awful.widget.layoutbox(s),
			layout = wibox.layout.fixed.horizontal
		},
		top = dpi(1),
		left = dpi(3),
		bottom = dpi(1),
		right = dpi(3),
		widget = wibox.container.margin
	},
	bg = beautiful.xbackground,
	fg = "#9F59E1",
	shape = helpers.rrect(beautiful.border_radius - 3),
	widget = wibox.container.background
}

lay_rrent:buttons(gears.table.join(
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
		awful.button({ }, 3, function () awesome.emit_signal("widgets::ll::toggle", mouse.screen) end)))

power_widget = wibox.widget{ power_button, layout = wibox.layout.align.horizontal }
reboot_widget = wibox.widget{ reboot_button, layout = wibox.layout.align.horizontal }
layout_widget = wibox.widget{ lay_rrent, layout = wibox.layout.align.horizontal }

local sym_widget = wibox.widget {
	{
		power_widget,
		reboot_widget,
		layout_widget,
		layout = wibox.layout.align.horizontal
	},
	top = dpi(5),
	left = dpi(5),
	bottom = dpi(5),
	right = dpi(5),
	widget = wibox.container.margin
}

local util_box = function(s, offset)
	local offsetx = 0

	if offset == true then
		offsetx = dpi(128)
		offsety = dpi(5)
	end

	local panel = wibox (
		{
			ontop = false,
			screen = s,
			height = dpi(24) + beautiful.widget_border_width,
			width = dpi(70),
			x = dpi(30),
			y = s.geometry.y + offsety,
			strech = false,
			bg = beautiful.xbackground .. "0",
			opacity = 0.9,
			struts = {
				top = dpi(24),
				bottom = dpi(24)
			}
		}
		)

	panel:struts (
		{
			top = dpi(0)
		}
		)

	panel:setup {
		layout = wibox.layout.fixed.horizontal,
		{
			{
				sym_widget,
				bg = beautiful.xbackground,
				shape = helpers.prrect(dpi(10), true, false, true, false),
				widget = wibox.container.background
			},
			top = dpi(1),
			left = dpi(2),
			bottom = dpi(1),
			right = dpi(2),
			widget = wibox.container.margin
		}
	}

	return panel
end

power_button:connect_signal("button::press", function(c, _, _, button)
	if button == 1 then
		awesome.emit_signal("widgets::down::toggle", mouse.screen)
	end
end)

reboot_button:connect_signal("button::press", function(c, _, _, button)
	if button == 1 then
		awesome.emit_signal("widgets::boot::toggle", mouse.screen)
	end
end)

return util_box
