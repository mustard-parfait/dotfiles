local awful		= require('awful')
local wibox		= require('wibox')
local beautiful	= require('beautiful')
local gears		= require('gears')
local helpers	= require('helpers')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local width = 200
local height = 150

local power_button = wibox.widget ({
		align = 'center',
		valign = 'center',
		font = beautiful.wid_font,
		text = "",
		widget = wibox.widget.textbox()
	})

power_button.markup = "<span foreground='" .. beautiful.xcolor0 .. "'>"..
						power_button.text .. "</span"

local yes_button = wibox.widget ({
		align = 'center',
		valign = 'center',
		font = beautiful.font_name .. "15",
		text = "Yes",
		widget = wibox.widget.textbox()
	})

yes_button.markup = "<span foreground='#E896E0'>"..
						yes_button.text .. "</span"

local no_button = wibox.widget ({
		align = 'center',
		valign = 'center',
		font = beautiful.font_name .. "15",
		text = "No",
		widget = wibox.widget.textbox()
	})

no_button.markup = "<span foreground='#E896E0'>"..
						no_button.text .. "</span"

local power_widget = {power_button, layout = wibox.layout.fixed.vertical}
local yes_widget = {
	{
		yes_button, 
		layout = wibox.layout.fixed.vertical
	},
	left = dpi(10),
	right = dpi(10),
	widget = wibox.container.margin
}
local no_widget = {
	{
		no_button, 
		layout = wibox.layout.fixed.vertical
	},
	left = dpi(10),
	right = dpi(10),
	widget = wibox.container.margin
}

local sym_widget = wibox.widget {
	{
		power_widget,
		layout = wibox.layout.align.vertical
	},
	top = dpi(5),
	left = dpi(5),
	bottom = dpi(5),
	right = dpi(5),
	widget = wibox.container.margin
}

local opt_widget = wibox.widget {
	{
		yes_widget,
		no_widget,
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

yes_button:connect_signal("button::press", function(c, _, _, button)
	if button == 1 then
		awful.util.spawn("sudo poweroff")
	end
end)

no_button:connect_signal("button::press", function(c, _, _, button)
	if button == 1 then
		awesome.emit_signal("widgets::down::toggle", mouse.screen)
	end
end)

return popup_widget
