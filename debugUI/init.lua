
--initialize EVERYTHING
debugUI = {windows = {}}

debugUI.loveframes = require "loveframes"

debugUI.windowPosition = 0

debugUI.getfield = function(f)
	local v = _G    -- start with the table of globals
	for w in string.gfind(f, "[%w_]+") do
		v = v[w]
	end
	return v
end

debugUI.setfield = function(f, v)
	local t = _G    -- start with the table of globals
	for w, d in string.gfind(f, "([%w_]+)(.?)") do
		if d == "." then      -- not last field?
			t[w] = t[w] or {}   -- create table if absent
			t = t[w]            -- get the table
		else                  -- last field
			t[w] = v            -- do the assignment
		end
	end
end

love.filesystem.getDirectoryItems( "debugUI/objects", function(file)
	local objectName = file:sub(1,file:len()-4)
	debugUI[objectName] = love.filesystem.load("debugUI/objects/" .. file)();
end )


debugUI.update = function(dt)
	debugUI.loveframes.update(dt)
	for i,v in ipairs(debugUI.windows) do
		v:update()
	end
end
debugUI.draw = function()
	debugUI.loveframes.draw()
end

debugUI.new = function(t,maxheight)
	
	local mainTable = {update = function(self) for i,v in ipairs(self) do v:update() end end}
	local totalheight = 0
	for i,v in ipairs(t) do
		local debugObject = debugUI[v.type](v)
		table.insert(mainTable,debugObject)
		totalheight = totalheight + debugObject.height
	end

	maxheight = math.min(maxheight or 400,totalheight+45)

	local window = debugUI.loveframes.Create("frame")
	window:SetPos(debugUI.windowPosition,0)
	window:SetSize(165,maxheight)
	debugUI.windowPosition = debugUI.windowPosition + 165


	local horizontalsList = debugUI.loveframes.Create("list",window)
	horizontalsList:SetDisplayType("vertical")
	horizontalsList:SetSize(165,maxheight-45)
	horizontalsList:SetPos(0,50)
	
	for i,debugObject in ipairs(mainTable) do
		local panel = debugObject:setup()
		horizontalsList:AddItem(panel)
	end
	table.insert(debugUI.windows,mainTable)
	return window
end


function debugUI.mousepressed(x, y, button)
	debugUI.loveframes.mousepressed(x, y, button)
end

function debugUI.mousereleased(x, y, button)
	debugUI.loveframes.mousereleased(x, y, button)
end

function debugUI.keypressed(key, unicode)
	if key == "f12" then
		for i,v in ipairs(debugUI.windows) do

		end
	end
	debugUI.loveframes.keypressed(key, unicode)
end

function debugUI.keyreleased(key,unicode)
	debugUI.loveframes.keyreleased(key)
end