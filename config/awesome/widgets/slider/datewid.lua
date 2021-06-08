local awful		= require('awful')
local beautiful	= require('beautiful')
local gears		= require('gears')
local wibox		= require('wibox')
local helpers	= require('helpers')
local awestore	= require('modules.awestore')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local date_text = wibox.widget {
	font		= "Sarasa UI HC 11",
	format		= "%a %b %d, %Y",
	align		= 'center',
	valign		= 'center',
	widget		= wibox.widget.textclock
}

date_text.markup = "<span foreground='#B8C6EC'>" ..
					date_text.text .. "</span>"

date_text:connect_signal("widget::redraw_needed", function()
    date_text.markup = "<span foreground='#B8C6EC'>" ..
                           date_text.text .. "</span>"
end)

local date_widget = wibox.widget {
	{
		date_text,
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
			date_widget,
			top = dpi(1),
			left = dpi(2),
			bottom = dpi(1),
			right = dpi(2),
			widget = wibox.container.margin
		},
		nil,
}

return clock_widget
