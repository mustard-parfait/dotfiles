local awful		= require('awful')
local wibox		= require('wibox')
local beautiful = require('beautiful')
local gears		= require('gears')
local helpers	= require('helpers')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local mysystray = wibox.widget.systray()
mysystray:set_base_size(beautiful.systray_icon_size)

local mysystray_container = {
		mysystray,
		top = dpi(1),
		left = dpi(3),
		bottom = dpi(3),
		right = dpi(1),
		widget = wibox.container.margin
}

local systray_box = function(s, offset)
	local offsetx = 0

	if offset == true then
		offsetx = dpi(128)
		offsety = dpi(5)
	end

	local final_systray = wibox.widget {
			{mysystray_container, top = dpi(1), layout = wibox.container.margin},
			bg = beautiful.xcolor0,
			shape = helpers.rrect(beautiful.border_radius - 3),
			widget = wibox.container.background
	}

	local systray_flex = {
		layout = wibox.layout.flex.horizontal,
		max_widget_size = 150,
	}

	local panel = wibox (
		{
			ontop = false,
			screen = s,
			height = dpi(24) + beautiful.widget_border_width,
			width = dpi(42),
			x = dpi(70),
			y = s.geometry.y + offsety,
			stretch = false,
			bg = beautiful.xbackground,
			fg = beautiful.xforeground,
            opacity = 0.9,
			struts = {
				top = dpi(24)
			}
		}
		)

	panel:struts (
		{
			top = dpi(0)
		}
		)

	panel:setup {
		layout = wibox.layout.stack,
		nil,
		{
			awful.widget.only_on_screen(final_systray, screen[1]),
			top = dpi(3),
			left = dpi(2),
			bottom = dpi(3),
			right = dpi(2),
			widget = wibox.container.margin
		},
		nil,
	}

	return panel
end

return systray_box
