local awful		  = require('awful')
local wibox		  = require('wibox')
local beautiful	  = require('beautiful')
local gears		  = require('gears')
local helpers	  = require('helpers')
local bling		  = require('bling')

local dpi		  = require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local img = wibox.widget {
	image = gears.surface.load_uncached(gears.filesystem.get_configuration_dir() .. "icons/no_music.png"),
	resize = true,
	forced_height = dpi(100),
	widget = wibox.widget.imagebox
}

local title_widget = wibox.widget {
	font = "Sarasa Fixed K 15",
	markup = 'No Title',
	align = 'center',
	valign = 'center',
	ellipsize = 'middle',
	forced_height = dpi(25),
	widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
	font = "Sarasa Fixed K 10",
	markup = 'No Artist',
	align = 'center',
	valign = 'center',
	ellipsize = 'center',
	forced_height = dpi(20),
	widget = wibox.widget.textbox
}

bling.signal.playerctl.enable()
awesome.connect_signal("bling::playerctl::title_artist_album",
    function(title, artist, image)
		title_widget:set_markup_silently('<span foreground="#FADE8F">' .. title .. '</span>')
		artist_widget:set_markup_silently('<span foreground="#E75B81">' .. artist .. '</span>')
        img:set_image(gears.surface.load_uncached(image))
    end)

local play_cmd = function() awful.spawn.with_shell("playerctl play-pause") end
local prev_cmd = function() awful.spawn.with_shell("playerctl previous") end
local next_cmd = function() awful.spawn.with_shell("playerctl next") end

local play_icon = wibox.widget {
	markup = helpers.colorize_text("", beautiful.xcolor4),
	font = beautiful.icon_font_name .. "15",
	align = 'center',
	valign = 'center',
	widget = wibox.widget.textbox()
}

local play_sym = wibox.widget {
	play_icon,
	forced_height = dpi(15),
	forced_width = dpi(15),
	widget = wibox.container.background
}

awesome.connect_signal("bling::playerctl::status", function(playing)
	if playing then
		play_icon.markup = helpers.colorize_text("", beautiful.xcolor4)
	else
		play_icon.markup = helpers.colorize_text("", beautiful.xcolor4)
	end
end)

play_sym:buttons(gears.table.join(
						awful.button({}, 1, function() play_cmd() end)))
play_sym:connect_signal("mouse::enter", function() 
	play_icon.markup = helpers.colorize_text(play_icon.text, beautiful.xforeground)
end)
play_sym:connect_signal("mouse::leave", function() 
	play_icon.markup = helpers.colorize_text(play_icon.text, beautiful.xcolor4)
end)

local prev_icon = wibox.widget {
	markup = helpers.colorize_text("", beautiful.xcolor4),
	font = beautiful.icon_font_name .. "15",
	align = 'center',
	valign = 'center',
	widget = wibox.widget.textbox()
}

local prev_sym = wibox.widget {
	prev_icon,
	forced_height = dpi(15),
	forced_width = dpi(15),
	widget = wibox.container.background
}

prev_sym:buttons(gears.table.join(
						awful.button({}, 1, function() prev_cmd() end)))
prev_sym:connect_signal("mouse::enter", function() 
	prev_icon.markup = helpers.colorize_text(prev_icon.text, beautiful.xforeground)
end)
prev_sym:connect_signal("mouse::leave", function() 
	prev_icon.markup = helpers.colorize_text(prev_icon.text, beautiful.xcolor4)
end)

local next_icon = wibox.widget {
	markup = helpers.colorize_text("", beautiful.xcolor4),
	font = beautiful.icon_font_name .. "15",
	align = 'center',
	valign = 'center',
	widget = wibox.widget.textbox()
}

local next_sym = wibox.widget {
	next_icon,
	forced_height = dpi(15),
	forced_width = dpi(15),
	widget = wibox.container.background
}

next_sym:buttons(gears.table.join(
						awful.button({}, 1, function() next_cmd() end)))
next_sym:connect_signal("mouse::enter", function() 
	next_icon.markup = helpers.colorize_text(next_icon.text, beautiful.xforeground)
end)
next_sym:connect_signal("mouse::leave", function() 
	next_icon.markup = helpers.colorize_text(next_icon.text, beautiful.xcolor4)
end)

local slider = wibox.widget {
	forced_height = dpi(10),
	bar_shape = gears.shape.rounded_bar,
	shape = gears.shape.rounded_bar,
	background_color = beautiful.stats_bg_color,
	color = "#AE9895",
	value = 25,
	max_value = 100,
	widget = wibox.widget.progressbar
}

awesome.connect_signal("bling::playerctl::position", function(pos, length)
	slider.value = (pos/length) * 100
end)

local player = wibox.widget {
	layout = wibox.layout.align.horizontal,
	expand = "none",
	nil,
	{
		{
			{
				{
					{
						title_widget,
						artist_widget,
						layout = wibox.layout.fixed.vertical
					},
					top = 10,
					left = 25,
					right = 25,
					widget = wibox.container.margin
				},
				{
					nil,
					{
						{
							prev_sym,
							play_sym,
							next_sym,
							spacing = dpi(40),
							layout = wibox.layout.fixed.horizontal
						},
						top = dpi(10),
						left = 25,
						right = 25,
						widget = wibox.container.margin
					},
					nil,
					expand = "none",
					layout = wibox.layout.align.horizontal
				},
				layout = wibox.layout.align.vertical
			},
			top = dpi(0),
			bottom = dpi(10),
			widget = wibox.container.margin
		},
		forced_height = 100,
		layout = wibox.layout.align.vertical
	},
	nil
}

return {
	player,
	shape = helpers.rrect(beautiful.client_radius),
	widget = wibox.container.background
}
