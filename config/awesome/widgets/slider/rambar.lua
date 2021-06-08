local awful		  = require('awful')
local wibox		  = require('wibox')
local beautiful	  = require('beautiful')
local gears		  = require('gears')
local helpers	  = require('helpers')

local dpi		  = require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")
require('tots.ram')

local icon_size = dpi(34)
local bar_size = dpi(200)

local ram_icon = wibox.widget.imagebox(beautiful.widget_mem)
ram_icon.forced_height = icon_size
ram_icon.forced_width = icon_size
ram_icon.resize = true

local ram_bar = wibox.widget {
	max_value = 100,
	forced_height = dpi(10),
	margins = {
		top = dpi(8),
		bottom = dpi(8),
	},
	forced_width = dpi(200),
	shape = gears.shape.rounded_bar,
	bar_shape = gears.shape.rounded_bar,
	color = "#E0DA37",
	background_color = beautiful.stats_bg_color,
	border_width = 0,
	border_color = beautiful.border_color,
	widget = wibox.widget.progressbar
}
ram_bar.forced_width = bar_size
ram_bar.shape = gears.shape.rounded_bar
ram_bar.bar_shape = gears.shape.rounded_bar

awesome.connect_signal("tots::ram", function(used, total)
	local ram_usage = (used/total) * 100
	ram_bar.value = ram_usage
end)

local ram = wibox.widget {
	nil,
	{
		ram_icon,
		ram_bar,
		spacing = dpi(10),
		layout = wibox.layout.fixed.horizontal
	},
	expand = "none",
	layout = wibox.layout.align.horizontal
}

return ram
