local awful		= require('awful')
local beautiful	= require('beautiful')
local gears		= require('gears')
local wibox		= require('wibox')
local helpers	= require('helpers')
local awestore	= require('modules.awestore')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local time_text = wibox.widget {
	font		= "Sarasa UI HC 45",
	format		= "%H%M",
	timezone	= "Z",
	align		= 'center',
	valign		= 'center',
	widget		= wibox.widget.textclock
}

time_text.markup = helpers.colorize_text(time_text.text, "#FFFFFF")

time_text:connect_signal("widget::redraw_needed", function()
	time_text.markup =  helpers.colorize_text(time_text.text:sub(1, 2), "#FFFFFF") ..
						helpers.colorize_text(time_text.text:sub(3, 4), "#B8C6EC")
end)

local time_widget = wibox.widget {
	{
		time_text,
		layout = wibox.layout.fixed.horizontal
	},
	top = dpi(5),
	left = dpi(5),
	bottom = dpi(5),
	right = dpi(5),
	widget = wibox.container.margin
}

local clock_widget = wibox.widget {
		layout = wibox.layout.align.horizontal,
		expand = "none",
		nil,
		{
			time_widget,
			top = dpi(1),
			left = dpi(2),
			bottom = dpi(1),
			right = dpi(2),
			widget = wibox.container.margin
		},
		nil,
}

return clock_widget
