local awful		= require('awful')

local update_interval = 5
local ram_script = [[
  sh -c "
  free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'
  "]]

awful.widget.watch(ram_script, update_interval, function(widget, stdout)
	local aval = stdout:match('(.*)@@')
	local total = stdout:match('@@(.*)@')
	local used = tonumber(total) - tonumber(aval)
	awesome.emit_signal("tots::ram", used, tonumber(total))
end)
