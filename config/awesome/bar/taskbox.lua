local awful		= require('awful')
local wibox		= require('wibox')
local beautiful	= require('beautiful')
local gears		= require('gears')
local helpers	= require('helpers')

local dpi		= require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local task_box = function(s, offset)
	local offsetx = 0

	if offset == true then
		offsetx = dpi(128)
		offsety = dpi(5)
	end

    local mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        buttons = tasklist_buttons,
		style = {
				shape_border_width = 1,
				shape = empty,
				fg_normal = "#EDA59B",
				fg_focus = "#EDA59B",
		},
		layout = {
				spacing = 10,
				spacing_widget = {
						{
								forced_width = 5,
								shape = gears.shape.circle,
								widget = wibox.widget.separator
						},
						valign = 'center',
						halign = 'center',
						widget = wibox.container.place,
				},
				layout = wibox.layout.flex.horizontal
		},
    }

	local task_pill = wibox.widget {
		{
			{mytasklist, top = dpi(1), widget = wibox.container.margin},
			layout = wibox.layout.fixed.horizontal
		},
		left = dpi(5),
		right = dpi(5),
		widget = wibox.container.margin
	}

	local panel = wibox (
		{
			ontop = false,
			screen = s,
			height = dpi(24) + beautiful.widget_border_width,
			width = dpi(400),
			x = s.geometry.width - dpi(1150),
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
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{
			layout = wibox.layout.fixed.horizontal,
			nil,
		},
		{
			{
				task_pill,
				bg = "#121018",
				shape = helpers.prrect(dpi(10), true, false, true, false),
				widget = wibox.container.background
			},
			top = dpi(1),
			left = dpi(2),
			bottom = dpi(1),
			right = dpi(2),
			widget = wibox.container.margin
		},
		{
			layout = wibox.layout.fixed.horizontal,
			nil,
		}
	}
	
	return panel
end

return task_box
