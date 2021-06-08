local awful		= require('awful')
local beautiful	= require('beautiful')
local gears		= require('gears')
local wibox		= require('wibox')
local helpers	= require('helpers')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local width = 100
local height = 100

local time_text = wibox.widget {
	font		= beautiful.font,
	format		= "%a %b %d, %H:%M ",
	timezone	= "Z",
	align		= 'center',
	valign		= 'center',
	widget		= wibox.widget.textclock
}

time_text.markup = "<span foreground='" .. beautiful.xcolor2 .. "'>" ..
					time_text.text .. "</span>"

time_text:connect_signal("widget::redraw_needed", function()
    time_text.markup = "<span foreground='" .. beautiful.xcolor2 .. "'>" ..
                           time_text.text .. "</span>"
end)

local date_widget = {time_text, layout = wibox.layout.fixed.vertical}
date_widget.font = beautiful.font_name .. "55"

local clock = wibox.widget {
	{
		date_widget,
		layout = wibox.layout.align.vertical
	},
	top = dpi(5),
	left = dpi(5),
	bottom = dpi(5),
	right = dpi(5),
	widget = wibox.container.margin
}

local widget_container = wibox.widget {
	{
		clock,
		left = dpi(15),
		right = dpi(15),
		top = dpi(10),
		bottom = dpi(10),
		widget = wibox.container.margin
	},
	forced_height = height,
	forced_width = width,
	layout = wibox.layout.fixed.vertical
}

local widget_bg = wibox.widget {
	widget_container,
	bg = beautiful.xbackground,
	border_color = beautiful.xcolor4,
	border_with = dpi(beautiful.widget_border_width),
	shape = helpers.prrect(dpi(25), false, false, false, false),
	widget = wibox.container.background
}

local popup_widget = awful.popup({
    widget = {widget_bg, widget = wibox.container.margin},
    visible = false,
    ontop = true,
    type = "dock",
    bg = beautiful.xbackground .. "00"
})

return popup_widget
