local awful		= require('awful')
local wibox		= require('wibox')
local beautiful = require('beautiful')
local gears		= require('gears')
local helpers = require("helpers")

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local time_text = wibox.widget {
	font		= beautiful.font,
	format		= "%a %b %d, %H:%M ",
	timezone	= "Z",
	align		= 'center',
	valign		= 'center',
	widget		= wibox.widget.textclock
}

time_text.markup = "<span foreground='#9ABEFF'>" ..
					time_text.text .. "</span>"

time_text:connect_signal("widget::redraw_needed", function()
    time_text.markup = "<span foreground='#9ABEFF'>" ..
                           time_text.text .. "</span>"
end)

local time_pill = wibox.widget {
	{
		helpers.horizontal_pad(5),
		{time_text, top = dpi(1), widget = wibox.container.margin},
		layout = wibox.layout.fixed.horizontal
	},
	left = dpi(6),
	right = dpi(5),
	widget = wibox.container.margin
}

local date_box = function(s, offset)
	local offsetx = 0

	if offset == true then
		offsetx = dpi(128)
		offsety = dpi(5)
	end

	local panel = wibox (
		{
			ontop = false,
			type = "desktop",
			screen = s,
			height = dpi(24) + beautiful.widget_border_width,
			width = dpi(130),
			x = s.geometry.width - dpi(160),
			y = s.geometry.y + offsety,
			strech = false,
			bg = beautiful.xbackground .. "1",
			fg = beautiful.xforeground,
			opacity = 0.9
		}
		)

	panel:struts (
		{
			top = dpi(0)
		}
		)

	panel:setup {
		layout = wibox.layout.fixed.horizontal,
		widget = wibox.container.background,
		{
			{
				time_pill,
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

return date_box
