local awful		  = require('awful')
local wibox		  = require('wibox')
local beautiful	  = require('beautiful') 
local gears		  = require('gears')
local helpers	  = require('helpers')

local dpi		  = require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")
require('tots.volume')

local icon_size = dpi(34)
local bar_size = dpi(200)

local vol_icon = wibox.widget.imagebox(beautiful.widget_vol)
vol_icon.forced_height = icon_size
vol_icon.forced_width = icon_size
vol_icon.resize = true

local vol_bar = wibox.widget {
	max_value = 100,
	forced_height = dpi(10),
	margins = {
		top = dpi(8),
		bottom = dpi(8),
	},
	forced_width = dpi(200),
	shape = gears.shape.rounded_bar,
	bar_shape = gears.shape.rounded_bar,
	color = "#9ABEFF",
	background_color = beautiful.stats_bg_color,
	border_width = 0,
	border_color = beautiful.border_color,
	widget = wibox.widget.progressbar
}
vol_bar.forced_width = bar_size
vol_bar.shape = gears.shape.rounded_bar
vol_bar.bar_shape = gears.shape.rounded_bar

awesome.connect_signal("tots::volume", function(volume, muted)
	if muted then
		fill_color = "#666666"
		bg_color = beautiful.stats_bg_color
	else
		fill_color = "#17C6FF"
		bg_color = beautiful.stats_bg_color
	end
	vol_bar.value = volume
	vol_bar.color = fill_color
	vol_bar.background_color = bg_color
end)

local volume = wibox.widget {
	nil,
	{
		vol_icon,
		vol_bar,
		spacing = dpi(10),
		layout = wibox.layout.fixed.horizontal
	},
	expand = "none",
	layout = wibox.layout.align.horizontal
}

return volume
