

-- local slider =

--initialize EVERYTHING
debugUI = {windows = {}}

debugUI.loveframes = require "loveframes"

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

debugUI.new = function(t)
	local window = debugUI.loveframes.Create("frame")
	window:SetPos(0,0)
	window:SetSize(400,200)

	local mainTable = {update = function(self) for i,v in ipairs(self) do v:update() end end}
	local totalwidth = 0
	local totalheight = 0
	local vertical = {}
	local horizontal = {}
	local page = {}
	for i,v in ipairs(t) do
		local debugObject = debugUI[v.type](v)
		table.insert(mainTable,debugObject)
		if debugObject.type == "vertical" then
			table.insert(vertical,debugObject)
			totalwidth = totalwidth + debugObject.width
		end
		--TODO; fix for horizontals and pages
	end

	local mainPanel = nil
	if #page > 0 then
	--TODO: fix for pages
	else
		mainPanel = debugUI.loveframes.Create("panel",window)
	end
	mainPanel:SetSize(400,180)
	mainPanel:SetPos(0,20)

	local position = 10
	local allowedwidth = (#horizontal > 0) and 200 or 380

	verticalsList = nil
	if #page == 0 and totalwidth <= allowedwidth then
		window:SetWidth(400-(allowedwidth-totalwidth))
		mainPanel:SetWidth(400-(allowedwidth-totalwidth))
	else
		verticalsList = debugUI.loveframes.Create("list",mainPanel)
		verticalsList:SetDisplayType("horizontal")
		verticalsList:SetSize(allowedwidth,165)
		verticalsList:SetPos(10,10)

	end

	for i,debugObject in ipairs(vertical) do
		local panel = debugObject:setup()
		if not verticalsList then
			panel:SetParent(mainPanel)
			panel:SetPos(position,10)
			position = position + debugObject.width
		else
			verticalsList:AddItem(panel)
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