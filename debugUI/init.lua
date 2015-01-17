
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

debugUI.new = function(t, maxheight, wname,...)
	local args = {...}

	local single = (type(t[1]) ~= "table")
	local tabbed = (type(t[1]) == "table") and (type(t[1][1]) == "table")
	local mainTable = {update = function(self) for i,v in ipairs(self) do v:update() end end}
	local totalheight = 0
	
	if single then
		local debugObject = debugUI[t.type](t)
		table.insert(mainTable,debugObject)
		totalheight = debugObject.height
	elseif tabbed then
		subheights = {}
		for j,u in ipairs(t) do
			local subTable = {update = function(self) for i,v in ipairs(self) do v:update() end end}
			local subheight = 0
			for i,v in ipairs(u) do
				local debugObject = debugUI[v.type](v)
				table.insert(subTable,debugObject)
				subheight = subheight + debugObject.height
			end
			mainTable[j] = subTable
			subheights[j] = subheight
		end
		totalheight = math.max(unpack(subheights))
	else
		for i,v in ipairs(t) do
			local debugObject = debugUI[v.type](v)
			table.insert(mainTable,debugObject)
			totalheight = totalheight + debugObject.height
		end
	end
	maxheight = math.min(maxheight or 400,totalheight+45,love.graphics.getHeight())

	local window = debugUI.loveframes.Create("frame")
	if wname then window:SetName(wname) end
	window:SetPos(debugUI.windowPosition,0)
	window:SetSize(165,maxheight)
	window.xpos = debugUI.windowPosition
	debugUI.windowPosition = debugUI.windowPosition + 165
	window.OnClose = function(object)
		if object:GetY() > love.graphics.getHeight() - 25 then
			object:SetPos(object.xpos,0)
		else
			object:SetPos(object.xpos,love.graphics.getHeight()-20)
		end
		return false
	end

	local tabs = nil

	local loops =  1
	if tabbed then
		loops = #t
		tabs = debugUI.loveframes.Create("tabs",window)
		tabs:SetPos(0,25)
		tabs:SetSize(165,maxheight-20)
		tabs:SetPadding(0)
	end
	for j = 1,loops do
		local horizontalsList = debugUI.loveframes.Create("list")
		horizontalsList:SetDisplayType("vertical")
		horizontalsList:SetSize(165,maxheight-45)
		if tabbed then
			tabs:AddTab(args[j] or ("Tab" ..j),horizontalsList)
		else
			horizontalsList:SetParent(window)
			horizontalsList:SetPos(0,50)
		end
		local searchable = tabbed and mainTable[j] or mainTable
		for i,debugObject in ipairs(searchable) do
			local panel = debugObject:setup()
			horizontalsList:AddItem(panel)
		end
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