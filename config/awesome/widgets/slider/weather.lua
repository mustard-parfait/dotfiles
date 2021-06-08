local awful		= require('awful')
local beautiful	= require('beautiful')
local gears		= require('gears')
local wibox		= require('wibox')
local helpers	= require('helpers')
local awestore	= require('modules.awestore')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")
require("tots.weather")

local weather_fg = "#F8C18C"
local temp_fg = "#F8C18C"
local dashboard_width = dpi(400)
local dashboard_border_width = 5

local function create_half_box(heading, body)
    local temp_wid = wibox.widget {
        {
            {
                {
                    {
                        nil,
                        {
                            helpers.vertical_pad(dpi(10)),
                            heading,
                            body,
                            helpers.vertical_pad(dpi(13)),
                            layout = wibox.layout.fixed.vertical
                        },
                        nil,
                        layout = wibox.layout.align.vertical
                    },
                    bg = secondary_bg,
                    shape = helpers.rrect(beautiful.corner_radius),
                    forced_width = (dashboard_width * 0.85 - dpi(10) - 4 * dashboard_border_width) / 2,
                    widget = wibox.container.background 
                },
                margins = dashboard_border_width,
                widget = wibox.container.margin
            },
            id = "border",
            bg = "#1e1c24",
            shape = helpers.rrect(beautiful.border_radius + dashboard_border_width / 2),
            widget = wibox.container.background
        },
        left = dpi(20),
        bottom = dpi(20),
        widget = wibox.container.margin
    }
    return temp_wid
end

local weather_heading = wibox.widget({
        align = "center",
        valign = "center",
        font = small_font,
        markup = helpers.colorize_text("?", temp_fg),
        widget = wibox.widget.textbox()
})

local weather_info = wibox.widget({
        align = "center",
        valign = "center",
	    font = "Sarasa UI HC 20",
        markup = helpers.colorize_text(" <i>Temperature\n<b>IRL</b></i>", weather_fg),
        widget = wibox.widget.textbox()
})

awesome.connect_signal("tots::weather", function(temp, wind, emoji)
  weather_heading.markup = helpers.colorize_text(tostring(temp) .. "°C", weather_fg)
  weather_info.markup = helpers.colorize_text(" <i>Temperature\n<b>IRL</b> (" .. tostring(wind) .. "km/h wind)</i>", weather_fg)
end)

local weather_widget = wibox.widget {
		layout = wibox.layout.align.horizontal,
		expand = "none",
		nil,
		{
            create_half_box(weather_heading, weather_widget),
			top = dpi(1),
			left = dpi(2),
			bottom = dpi(1),
			right = dpi(2),
			widget = wibox.container.margin
        },
		nil,
}

return weather_widget
