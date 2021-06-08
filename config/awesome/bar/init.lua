local awful		  = require('awful')
local wibox		  = require('wibox')
local beautiful   = require('beautiful')
local gears		  = require('gears')
local bling       = require('bling')
local date_box    = require('bar.datebox')
local tag_box     = require('bar.tagbox')
local util_box    = require('bar.utilbox')
local systray_box = require('bar.systraybox')
local task_box    = require('bar.taskbox')
local spoti_box   = require('bar.spotibox')

awful.screen.connect_for_each_screen (
	function(s)
		if s.index == 1 then
			s.date_box = date_box(s, true)
            s.tag_box = tag_box(s, true)
            s.util_box = util_box(s, true)
            s.task_box = task_box(s, true)
            s.spoti_box = spoti_box(s, true)
		else
			s.date_box = date_box(s, false)
            s.tag_box = tag_box(s, false)
            s.util_box = util_box(s, false)
            s.task_box = task_box(s, false)
            s.spoti_box = spoti_box(s, false)
		end
	end
)

for s in screen do
    screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients <= 0 then
          s.task_box.visible = false
        else
          s.task_box.visible = true
        end
    end)
end

function updateBarsVisibility()
	for s in screen do
		if s.selected_tag then
			local fullscreen = s.selected_tag.fullscreenMode

			s.date_box.visible = not fullscreen
			s.tag_box.visible = not fullscreen
			s.util_box.visible = not fullscreen
			s.task_box.visible = not fullscreen
			s.spoti_box.visible = not fullscreen

		end
	end
end

_G.tag.connect_signal(
  'property::selected',
  function(t)
    updateBarsVisibility()
  end
)

_G.client.connect_signal(
  'property::fullscreen',
  function(c)
    c.screen.selected_tag.fullscreenMode = c.fullscreen
    updateBarsVisibility()
  end
)

_G.client.connect_signal(
  'unmanage',
  function(c)
    if c.fullscreen then
      c.screen.selected_tag.fullscreenMode = false
      updateBarsVisibility()
    end
  end
)
