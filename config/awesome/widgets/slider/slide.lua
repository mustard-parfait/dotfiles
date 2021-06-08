local awful		= require('awful')
local wibox		= require('wibox')
local beautiful	= require('beautiful')
local gears		= require('gears')
local helpers	= require('helpers')

local time		= require('widgets.slider.damewid')
local date		= require('widgets.slider.datewid')
local player	= require('widgets.slider.player')
local cpu		= require('widgets.slider.cpubar')
local ram		= require('widgets.slider.rambar')
local volume	= require('widgets.slider.volbar')
local battery	= require('widgets.slider.batbar')
local info		= require('widgets.slider.info')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local width = 380
local height = 1080

local clock_widget = wibox.widget {
	{
		{
			time,
			align = "center",
			valign = "center",
			widget = wibox.container.background
		},
		top = dpi(15),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	{
		{
			date,
			align = "center",
			valign = "center",
			widget = wibox.container.background
		},
		top = dpi(1),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	forced_height = 150,
	widget = wibox.layout.fixed.vertical
}

local info_widget = wibox.widget {
	{
		{
			info,
			widget = wibox.container.background
		},
		top = dpi(1),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	widget = wibox.layout.fixed.vertical
}

local empty_widget = wibox.widget {
	{
		{
			widget = wibox.container.background
		},
		top = dpi(1),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	forced_height = dpi(2);
	widget = wibox.layout.fixed.vertical
}

local ress = wibox.widget {
	{
		{
			cpu,
			align = "center",
			valign = "center",
			widget = wibox.container.background
		},
		top = dpi(15),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	{
		{
			ram,
			align = "center",
			valign = "center",
			widget = wibox.container.background
		},
		top = dpi(1),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	{
		{
			volume,
			align = "center",
			valign = "center",
			widget = wibox.container.background
		},
		top = dpi(1),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	{
		{
			battery,
			align = "center",
			valign = "center",
			widget = wibox.container.background
		},
		top = dpi(1),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	forced_height = dpi(170),
	widget = wibox.layout.fixed.vertical
}

local widget_container = wibox.widget {
	{
		{
			clock_widget,
			bg = "#1e1c24",
			shape = helpers.rrect(dpi(5)),
			widget = wibox.container.background
		},
		top = dpi(250),
		left = dpi(15),
		bottom = dpi(10),
		right = dpi(15),
		widget = wibox.container.margin
	},
	{
		{
			empty_widget,
			bg = "#1e1c24",
			shape = helpers.rrect(dpi(5)),
			widget = wibox.container.background
		},
		top = dpi(10),
		left = dpi(15),
		bottom = dpi(10),
		right = dpi(15),
		widget = wibox.container.margin
	},
	{
		{
			ress,
			bg = "#1e1c24",
			shape = helpers.rrect(dpi(5)),
			widget = wibox.container.background
		},
		top = dpi(10),
		left = dpi(15),
		bottom = dpi(10),
		right = dpi(15),
		widget = wibox.container.margin
	},
	{
		{
			empty_widget,
			bg = "#1e1c24",
			shape = helpers.rrect(dpi(5)),
			widget = wibox.container.background
		},
		top = dpi(10),
		left = dpi(15),
		bottom = dpi(10),
		right = dpi(15),
		widget = wibox.container.margin
	},
	{
		{
			info_widget,
			bg = "#1e1c24",
			shape = helpers.rrect(dpi(5)),
			widget = wibox.container.background
		},
		top = dpi(10),
		left = dpi(15),
		bottom = dpi(10),
		right = dpi(15),
		widget = wibox.container.margin
	},
	forced_height = height,
	forced_width = width,
	widget = wibox.layout.fixed.vertical
}

local widget_bg = wibox.widget {
	{
		{
			widget_container,
			bg = "#121018",
			border_color = beautiful.xcolor4,
			border_width = dpi(beautiful.widget_border_width),
			shape = helpers.rrect(dpi(15)),
			widget = wibox.container.background
		},
		top = dpi(20),
		widget = wibox.container.margin
	},
	bg = beautiful.xbackground,
	shape = helpers.prrect(dpi(25), false, false, false, false),
	widget = wibox.container.background
}

local popup_widget = awful.popup ({
    widget = {widget_bg, widget = wibox.container.margin},
    visible = false,
    ontop = true,
    type = "dock",
    bg = beautiful.xbackground .. "00"
})

return popup_widget
