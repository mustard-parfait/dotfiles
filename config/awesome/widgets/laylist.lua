local awful		= require('awful')
local wibox		= require('wibox')
local beautiful	= require('beautiful')
local gears		= require('gears')
local helpers	= require('helpers')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local width = 280
local height = 200

local layout_box = awful.widget.layoutlist {
    source = awful.widget.layoutlist.source.default_layouts, -- DOC_HIDE
    spacing = dpi(20),
    base_layout = wibox.widget {
        spacing = dpi(20),
        forced_num_cols = 3,
        layout = wibox.layout.grid.vertical
    },
    widget_template = {
        {
            {
                id = 'icon_role',
                forced_height = dpi(60),
                forced_width = dpi(60),
                widget = wibox.widget.imagebox
            },
            margins = dpi(20),
            widget = wibox.container.margin
        },
        id = 'background_role',
        forced_width = dpi(60),
        forced_height = dpi(60),
        widget = wibox.container.background
    }
}

local opt_widget = wibox.widget {
	{
		layout_box,
		layout = wibox.layout.align.horizontal
	},
	top = dpi(5),
	left = dpi(10),
	bottom = dpi(5),
	right = dpi(10),
	widget = wibox.container.margin
}

local widget_container = wibox.widget {
	{
		{
			sym_widget,
			fg = beautiful.xcolor0,
			widget = wibox.container.background
		},
		top = dpi(10),
		bottom = dpi(10),
		widget = wibox.container.margin
	},
	{
		{
			opt_widget,
			fg = "#D5BAB3",
			bg = beautiful.xcolor0,
			shape = helpers.prrect(beautiful.border_radius - 3, true, false, true, false),
			widget = wibox.container.background
		},
		left = dpi(35),
		right = dpi(40),
		top = dpi(10),
		bottom = dpi(10),
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
			fg = beautiful.xcolor10,
			bg = "#47526C",
			shape = helpers.rrect(beautiful.border_radius - 3),
			widget = wibox.container.background
		},
		top = dpi(15),
		left = dpi(15),
		bottom = dpi(15),
		right = dpi(15),
		widget = wibox.container.margin
	},
	bg = beautiful.xbackground,
	border_color = beautiful.xcolor4,
	border_with = dpi(beautiful.widget_border_width),
	shape = helpers.prrect(dpi(25), false, true, true, false),
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
