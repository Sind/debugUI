local angle = debugUI.loveframes.class('angle')

angle.initialize = function(self,v)
	self.var = v.var
	self.name = v.name or self.var
	self.height = 180
	self.val = v.val or debugUI.getfield(self.var) or 0
	self.tooltip = v.tooltip
	debugUI.setfield(self.var,self.val)
end

angle.update = function(self)
	local oldGlobal = debugUI.getfield(self.var)
	local oldUI = self.ui.button.val
	if oldUI ~= self.val then
		self.val = oldUI
		debugUI.setfield(self.var,self.val)
	elseif oldGlobal ~= self.val then
		self.val = oldGlobal
		self.ui.button.val = self.val
	end
	self.ui.value:SetText(string.format("%.2f",self.val))
end

angle.setup = function(self)
	self.ui = {}
	local panel = debugUI.loveframes.Create("panel")
	panel:SetSize(150,self.height)
	local button = debugUI.loveframes.Create("button",panel)
	button:SetPos(10,28)
	button:SetSize(130,130)
	button.val = self.val
	button.r = self.r
	button.draw = function(self)
		local center = {x = self.x + 65, y = self.y+65}
		local edge = {}
		edge.x = 65* math.cos(self.val)
		edge.y = 65* math.sin(self.val)
		love.graphics.setColor(0, 128, 0, 128)
		love.graphics.arc("fill",center.x,center.y,65,0,self.val)
		love.graphics.setColor(128, 128, 128, 255)
		love.graphics.circle("line", center.x, center.y, 65)
		love.graphics.line(center.x, center.y, center.x+65, center.y)
		love.graphics.setColor(0, 128, 0, 255)
		love.graphics.arc("line",center.x,center.y,10,0,self.val)
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.line(center.x, center.y, center.x+edge.x, center.y+edge.y)
	end

	button.OnHover = function(self)
		if love.mouse.isDown(1) then
			local x,y = love.mouse.getPosition()
			local center = {x = self.x+65, y = self.y+65}
			self.val = math.atan2(y-center.y,x-center.x)
			if self.val < 0 then self.val = self.val + 2*math.pi end
		end
	end

	local name = debugUI.loveframes.Create("text", panel)
	name:SetText(self.name)
	name:SetPos(2,2)

	local value = debugUI.loveframes.Create("text",panel)
	value:SetText(string.format("%.2f",self.val))
	value:SetPos(2,166)
	self.ui.panel = panel
	self.ui.button = button
	self.ui.name = name
	self.ui.value = value
	return self.ui.panel
end

return angle