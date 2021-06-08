local awful      = require('awful')
local beautiful  = require('beautiful')
local wibox      = require('wibox')
local gears      = require('gears')
local helpers    = require('helpers')
local bling      = require('bling')

local dpi        = require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tag_box = function(s, offset)
    local offsetx = 0

    if offset == true then
        offsetx = dpi(128)
        offsety = dpi(5)
    end

	local gfs = gears.filesystem
    local ghost = gears.surface.load_uncached(
                      gfs.get_configuration_dir() .. "icons/ghosts/ghost.png")
    local ghost_icon = gears.color.recolor_image(ghost, "#F8C18C")
    local dot = gears.surface.load_uncached(
                    gfs.get_configuration_dir() .. "icons/ghosts/dot.png")
    local dot_icon = gears.color.recolor_image(dot, "#2c2c4b")
    local pacman = gears.surface.load_uncached(
                       gfs.get_configuration_dir() .. "icons/ghosts/pacman.png")
    local pacman_icon = gears.color.recolor_image(pacman, "#97DB99")

    local update_tags = function(self, c3)
        local imgbox = self:get_children_by_id('icon_role')[1]
        if c3.selected then
            imgbox.image = pacman_icon
        elseif #c3:clients() == 0 then
            imgbox.image = dot_icon
        else
            imgbox.image = ghost_icon
        end
    end

    local taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
		shape = {shape = gears.shape.rectangle},
		style = {
				shape = empty,
				fg_normal = "#a5c1d1",
				fg_focus = "#5068A2",
				bg_normal = beautiful.xbackground,
				bg_focus = beautiful.xbackground,
		},
		widget_template = {
            {
                {id = 'icon_role', widget = wibox.widget.imagebox},
                id = 'margin_role',
                top = dpi(7),
                bottom = dpi(7),
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tags(self, c3)
                self:connect_signal('mouse::enter', function()
                    if #c3:clients() > 0 then
                        awesome.emit_signal("bling::tag_preview::update", c3)
                        awesome.emit_signal("bling::tag_preview::visibility", s,
                                            true)
                    end
                    if self.bg ~= beautiful.xbackground .. "60" then
                        self.backup = self.bg
                        self.has_backup = true
                    end
                    self.bg = beautiful.xbackground .. "60"
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::tag_preview::visibility", s,
                                        false)
                    if self.has_backup then
                        self.bg = self.backup
                    end
                end)
            end,
            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        },
    }

    local taglist_pill = wibox.widget {
            {
                    {taglist, top = dpi(1), widget = wibox.container.margin},
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
            width = dpi(130),
            x = s.geometry.width - dpi(300),
            y = s.geometry.y + offsety,
            strech = false,
            bg = beautiful.xbackground .. "0",
            fg = beautiful.xforeground,
            opacity = 0.9,
            struts = {
                top = dpi(24),
                bottom = dpi(24)
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
		widget = wibox.container.background,
        {
            {
                taglist_pill,
				bg = beautiful.xbackground,
				shape = helpers.prrect(dpi(10), true, false, true, false),
                widget = wibox.container.background
            },
            top = dpi(1),
            widget = wibox.container.margin
        }
    }

    return panel
end

return tag_box
