local slider = loveframes.class('slider')

slider.initialize =  function(self,k,v)
	self.type = "vertical"
	self.width = math.max(love.graphics.getFont():getWidth(k)+4,60)
	self.var = k
	self.val = _G[k] or v[2]
	_G[k] = self.val
	self.min = v[2] or 0
	self.max = v[3] or 1
end

slider.update = function(self)
	local oldGlobal = debugUI.getfield(self.var)
	local oldUI = self.ui.slider:GetValue()
	if oldUI ~= self.val then
		self.val = oldUI
		debugUI.setfield(self.var,self.val)
	elseif oldGlobal ~= self.val then
		self.val = oldGlobal
		self.ui.slider:SetValue(self.val)
	end
	self.ui.value:SetText(string.format("%.2f",self.val))
end

slider.setup = function(self)
	self.ui = {}
	local panel = loveframes.Create("panel")
	panel:SetSize(self.width,150)
	local name = loveframes.Create("text",panel)
	name:SetText(self.var)
	name:SetPos(2,2)
	local slider = loveframes.Create("slider", panel)
	slider:SetSlideType("vertical")
	slider:SetHeight(100)
	slider:SetButtonSize(20, 10)
	slider:SetPos(self.width/2-10,25)
	slider:SetMinMax(self.min,self.max)
	slider:SetValue(self.val)
	local value = loveframes.Create("text", panel)
	value:SetText(string.format("%.2f",self.val))
	value:SetPos(2,135)
	self.ui.panel = panel
	self.ui.slider = slider
	self.ui.name = name
	self.ui.value = value
	-- returns appropriate loveframes object
	return self.ui.panel
end

return slider