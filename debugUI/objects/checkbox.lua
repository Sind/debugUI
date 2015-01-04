local checkbox = debugUI.loveframes.class('checkbox')

checkbox.initialize = function(self,v)
	self.type = "horizontal"
	self.var = v.var
	self.name = v.name or self.var
	self.height = 30
	self.val = debugUI.getfield(self.var) or v.val or false
	debugUI.setfield(self.var,self.val)
end

checkbox.update = function(self)
	local oldGlobal = debugUI.getfield(self.var)
	local oldUI = self.ui.checkbox:GetChecked()
	if oldUI ~= self.val then
		self.val = oldUI
		debugUI.setfield(self.var,self.val)
	elseif oldGlobal ~= self.val then
		self.val = oldGlobal
		self.ui.checkbox:SetChecked(self.val)
	end
end

checkbox.setup = function(self)
	self.ui = {}
	local panel = debugUI.loveframes.Create("panel")
	panel:SetSize(150,30)
	local checkbox = debugUI.loveframes.Create("checkbox",panel)
	checkbox:SetPos(5,5)
	checkbox:SetText(self.name)
	checkbox:SetChecked(self.val)
	self.ui.panel = panel
	self.ui.checkbox = checkbox
	return panel
end

return checkbox