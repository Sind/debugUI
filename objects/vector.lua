local vector = debugUI.loveframes.class('vector')

vector.initialize = function(self,v)
	self.var = v.var
	self.name = v.name or self.var
	self.height = 180
	self.r = v.r or 1
	self.val = v.val or debugUI.getField(self.var) or {self.r,0}
	self.tooltip = v.tooltip
	debugUI.setfield(self.var,self.val)
end

vector.update = function(self)
	local oldGlobal = debugUI.getfield(self.var)
	local oldUI = self.ui.button.val
	if oldUI ~= self.val then
		self.val = oldUI
		debugUI.setfield(self.var,self.val)
	elseif oldGlobal ~= self.val then
		self.val = oldGlobal
		self.ui.button.val = self.val
	end
	self.ui.value:SetText(string.format("(%.2f,%.2f)",self.val[1],self.val[2]))
end

vector.setup = function(self)
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
		edge.x = 65*self.val[1]/self.r
		edge.y = 65*self.val[2]/self.r
		local len = math.sqrt(self.val[1]*self.val[1]+self.val[2]*self.val[2])
		local a = math.atan2(edge.y,edge.x)
		local a1 = a + math.pi/4*5
		local a2 = a - math.pi/4*5
		local p1 = {5*math.cos(a1),5*math.sin(a1)}
		local p2 = {5*math.cos(a2),5*math.sin(a2)}
		love.graphics.setColor(128, 128, 128, 255)
		love.graphics.circle("line", center.x, center.y, 65)
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.line(center.x, center.y, center.x+edge.x, center.y+edge.y)
		love.graphics.line(center.x+edge.x+p1[1], center.y+edge.y+p1[2],center.x+edge.x, center.y+edge.y)
		love.graphics.line(center.x+edge.x+p2[1], center.y+edge.y+p2[2],center.x+edge.x, center.y+edge.y)

	end
	button.OnHover = function(self)
		if love.mouse.isDown(1) then
			local x,y = love.mouse.getPosition()
			local center = {x = self.x+65,y = self.y+65}
			self.val = {(x-center.x)*self.r/65,(y-center.y)*self.r/65}
			local len = math.sqrt(self.val[1]*self.val[1]+self.val[2]*self.val[2])
			if len > self.r then
				self.val[1] = self.val[1] * self.r/len
				self.val[2] = self.val[2] * self.r/len
			end
		end
	end
	local name = debugUI.loveframes.Create("text",panel)
	name:SetText(self.name)
	name:SetPos(2,2)
	local value = debugUI.loveframes.Create("text",panel)
	value:SetText(string.format("(%.2f,%.2f)",self.val[1],self.val[2]))
	value:SetPos(2,166)
	self.ui.panel = panel
	self.ui.button = button
	self.ui.name = name
	self.ui.value = value
	return self.ui.panel
end

return vector