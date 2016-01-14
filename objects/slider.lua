local slider = debugUI.loveframes.class('slider')

--initialize function sets the basic required variables,
--using input table v
slider.initialize = function(self,v)
	self.var = v.var
	self.name = v.name or self.var
	self.height = 60-- math.max(love.graphics.getFont():getWidth(self.name)+4,60)
	self.min = v.min or 0
	self.max = v.max or 1
	self.val = v.val or debugUI.getfield(self.var) or self.min
	self.tooltip = v.tooltip
	debugUI.setfield(self.var,self.val)
end

--update function runs every update, checks for changes and synchs values
--also has to change the ui as appropriate
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

--setup is an initialization function that shoud set up the ui for the widget
--all widgets have width 150, and height defined in the initialize function.
--setup returns a panel that contains the entire ui
slider.setup = function(self)
	self.ui = {}
	local panel = debugUI.loveframes.Create("panel")
	panel:SetSize(150,self.height)
	local name = debugUI.loveframes.Create("text",panel)
	name:SetText(self.name)
	name:SetPos(2,2)
	local slider = debugUI.loveframes.Create("slider", panel)
	slider:SetWidth(130)
	slider:SetPos(10,20)
	slider:SetMinMax(self.min,self.max)
	slider:SetValue(self.val)
	local value = debugUI.loveframes.Create("text", panel)
	value:SetText(string.format("%.2f",self.val))
	value:SetPos(2,44)

	self.ui.panel = panel
	self.ui.slider = slider
	self.ui.name = name
	self.ui.value = value
	-- returns appropriate loveframes object
	return self.ui.panel
end

return slider