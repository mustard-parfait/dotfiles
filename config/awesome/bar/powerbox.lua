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
		left = dpi(7),
		right = dpi(7),
		widget = wibox.container.margin
	},
	bg = beautiful.xbackground,
	fg = "#9F59E1",
	shape = helpers.rrect(beautiful.border_radius - 3),
	widget = wibox.container.background
}

local power_box = function(s, offset)
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
			width = dpi(30),
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
				power_button,
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

return power_box
