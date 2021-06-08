local awful		= require('awful')
local wibox		= require('wibox')
local beautiful	= require('beautiful')
local gears		= require('gears')
local helpers	= require('helpers')
local bling		= require('bling')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local song_title = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local song_artist = wibox.widget {
    markup = 'nothing playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local song_logo = wibox.widget {
    markup = '<span foreground="#76B06B"></span>',
    font = beautiful.icon_font,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local playerctl_bar = wibox.widget {
    {
        {
            {
                song_logo,
                widget = wibox.container.margin
            },
            {
                {
                    song_artist,
                    expand = "outside",
                    layout = wibox.layout.align.vertical
                },
                top = dpi(1),
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            {
                {
                    song_title,
                    expand = "outside",
                    layout = wibox.layout.align.vertical
                },
                top = dpi(1),
                left = dpi(10),
                widget = wibox.container.margin
            },
            spacing = 1,
            spacing_widget = {
                bg = beautiful.xcolor8,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
    },
    bg = beautiful.xcolor0,
    shape = helpers.rrect(beautiful.border_radius - 3),
    widget = wibox.container.background
}

bling.signal.playerctl.enable {
    backend = "playerctl_lib",
    ignore = "firefox",
    player = {"spotify"}
}

playerctl_bar.visible = true

awesome.connect_signal("bling::playerctl::no_players",
                       function() playerctl_bar.visible = false end)

awesome.connect_signal("bling::playerctl::title_artist_album",
                       function(title, artist, _)

    playerctl_bar.visible = true
    song_title.markup = '<span foreground="#FFDBCB">' ..
                            title .. '</span>'

    song_artist.markup = '<span foreground="#E75B81">' ..
                             artist .. '</span>'
end)

local spoti_pill = wibox.widget {
	{
		{playerctl_bar, top = dpi(1), widget = wibox.container.margin},
		layout = wibox.layout.fixed.horizontal
	},
	left = dpi(5),
	right = dpi(5),
	widget = wibox.container.margin
}

local spoti_box = function(s, offset)
	local offsetx = 0

	if offset == true then
		offsetx = dpi(128)
		offsety = dpi(5)
	end

	local panel = wibox (
		{
			ontop = false,
			screen = s,
			height = dpi(24) + beautiful.widget_border_width,
			width = dpi(300),
			x = dpi(100),
			y = s.geometry.y + offsety,
			strech = false,
			bg = beautiful.xbackground .. "0",
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
		layout = wibox.layout.fixed.horizontal,
		{
			{
				spoti_pill,
				bg = beautiful.xbackground,
				shape = helpers.prrect(dpi(10), true, false, true, false),
				widget = wibox.container.background
			},
			top = dpi(1),
			left = dpi(2),
			bottom = dpi(1),
			right = dpi(2),
			widget = wibox.container.margin
		},
	}
	
	return panel
end

return spoti_box
