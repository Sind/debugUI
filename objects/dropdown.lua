local dropdown = debugUI.loveframes.class('dropdown')

dropdown.initialize = function(self,v)
	self.var = v.var
	self.name = v.name or self.var
	self.height = 50
	self.vals = v.vals
	self.val = v.val or debugUI.getfield(self.var) or nil
	self.tooltip = v.tooltip
	debugUI.setfield(self.var,self.val)
end

dropdown.update = function(self)
	local oldGlobal = debugUI.getfield(self.var)
	local oldUI = self.ui.multichoice:GetChoice()
	if oldUI == "" then oldUI = nil end
	if oldUI ~= self.val then
		self.val = oldUI
		debugUI.setfield(self.var,self.val)
	elseif oldGlobal ~= self.val then
		self.val = oldGlobal
		self.ui.multichoice:SetChoice(self.val)
	end
end

dropdown.setup = function(self)
	self.ui = {}
	local panel = debugUI.loveframes.Create("panel")
	panel:SetSize(150,50)
	local name = debugUI.loveframes.Create("text",panel)
	name:SetPos(2,2)
	name:SetText(self.name)
	local multichoice = debugUI.loveframes.Create("multichoice",panel)

	multichoice:SetPos(10,20)
	multichoice:SetSize(130,20)
	for i,v in ipairs(self.vals) do
		multichoice:AddChoice(v)
	end
	if self.val then multichoice:SetChoice(self.val) end
	self.ui.panel = panel
	self.ui.name = name
	self.ui.multichoice = multichoice
	return self.ui.panel
end

return dropdown