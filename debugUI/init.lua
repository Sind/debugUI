loveframes = require "loveframes"

-- local slider =

--initialize EVERYTHING
debugUI = {windows = {}}

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
	debugUI[objectName] = dofile("debugUI/objects/" .. file);
end )


debugUI.update = function(dt)
	loveframes.update(dt)
	for i,v in ipairs(debugUI.windows) do
		v:update()
	end
end
debugUI.draw = function()
	loveframes.draw()
end

debugUI.new = function(t)
	local window = loveframes.Create("frame")
	window:SetPos(0,0)
	window:SetSize(400,200)

	local mainTable = {update = function(self) for i,v in ipairs(self) do v:update() end end}
	local totalwidth = 0
	local totalheight = 0
	local vertical = {}
	local horizontal = {}
	local page = {}
	for k,v in pairs(t) do
		local debugObject = debugUI[v[1]](k,v)
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
		mainPanel = loveframes.Create("panel",window)
	end
	mainPanel:SetSize(400,180)
	mainPanel:SetPos(0,20)

	local position = 10
	local allowedWidth = #horizontal > 0 and 200 or 380
	
	for i,debugObject in ipairs(vertical) do
		local panel = debugObject:setup()
		panel:SetParent(mainPanel)
		panel:SetPos(position,10)
		position = position + debugObject.width
	end

	table.insert(debugUI.windows,mainTable)
	return window
end


function debugUI.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end

function debugUI.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function debugUI.keypressed(key, unicode)
	loveframes.keypressed(key, unicode)
end

function debugUI.keyreleased(key,unicode)
	loveframes.keyreleased(key)
end

return debugUI 