local awful		= require('awful')
local beautiful	= require('beautiful')
local gears		= require('gears')
local wibox		= require('wibox')
local helpers	= require('helpers')
local awestore	= require('modules.awestore')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local me = wibox.widget.imagebox(beautiful.info_me)
me.resize = true
me.forced_height = dpi(91)
me.forced_width = dpi(91)

local information = wibox.widget {
	font		= "Sarasa UI HC 10",
    markup      = helpers.colorize_text("A database can't draw conclusions\n                                        - Satoshi", "#8661bc"),
	align		= 'center',
	valign		= 'center',
    widget       = wibox.widget.textbox()
}

local info = wibox.widget {
    {
        {
            {
                me,
                information,
                widget = wibox.layout.align.horizontal
            },
            {
                left = dpi(25),
                right = dpi(25),
                top = dpi(5),
                bottom = dpi(5),
                widget = wibox.container.margin
            },
            widget = wibox.container.background
        },
        top = dpi(20),
        left = dpi(20),
        bottom = dpi(0),
        right = dpi(20),
        widget = wibox.container.margin
    },
    halign = "left",
    valign = "left",
    widget = wibox.container.place
}

local info_widget = wibox.widget {
	{
		{
            me,
			widget = wibox.container.background
		},
		top = dpi(10),
        left = dpi(20),
		bottom = dpi(1),
		widget = wibox.container.margin
	},
	{
		{
			information,
			widget = wibox.container.background
		},
		top = dpi(1),
		bottom = dpi(1),
        right = dpi(10),
		widget = wibox.container.margin
	},
	widget = wibox.layout.fixed.horizontal
}

return info_widget
