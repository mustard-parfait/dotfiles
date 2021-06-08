local awful		= require('awful')
local beautiful	= require('beautiful')
local gears		= require('gears')
local wibox		= require('wibox')
local helpers	= require('helpers')
local awestore	= require('modules.awestore')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")
local time		= require('widgets.slider.damewid')
local date		= require('widgets.slider.datewid')

local clock_widget = wibox.widget {
	helpers.vertical_pad(dpi(20)),
	{
		{
			{
				{
					{
						time,
						date,
						helpers.vertical_pad(dpi(12)),
						layout = wibox.layout.fixed.vertical
					},
					forced_width = helpers.rrect(beautiful.border_radius),
					bg = "#1e1c24";
					widget = wibox.container.background
				},
				margins = 5,
				widget = wibox.container.margin
			},
			id = "border",
			bg = "#121018",
			shape = helpers.rrect(beautiful.border_radius + 2),
			widget = wibox.container.background
		},
		forced_width = dpi(400) * 0.85,
		left = dpi(20),
		right = dpi(20),
		bottom = dpi(20),
		widget = wibox.container.margin,
	},
	layout = wibox.layout.fixed.vertical
}

clock_widget:connect_signal("mouse::enter", function()
	temp_wid:get_children_by_id("border")[1].bg = "#1e1c2f"
end)
clock_widget:connect_signal("mouse::leave", function()
	temp_wid:get_children_by_id("border")[1].bg = "#121018"
end)

return clock_widget
