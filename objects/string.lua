local string = debugUI.loveframes.class('string')

string.initialize = function(self,v)
	self.var = v.var
	self.name = v.name or self.var
	self.height = 50
	self.val = v.val or debugUI.getfield(self.var) or ""
	print(self.var)
	debugUI.setfield(self.var,self.val)
	if v.editable == false then
		self.editable = false
	else
		self.editable = true
	end
end

string.update = function(self)
	local oldGlobal = debugUI.getfield(self.var)
	local oldUI = self.ui.textinput:GetText()
	if oldUI ~= self.val then
		self.val = oldUI
		debugUI.setfield(self.var,self.val)
	elseif oldGlobal ~= self.val then
		self.val = oldGlobal
		self.ui.textinput:SetText(self.val)
	end
end

string.setup = function(self)
	self.ui = {}
	local panel = debugUI.loveframes.Create("panel")
	panel:SetSize(150,50)
	local name = debugUI.loveframes.Create("text",panel)
	name:SetPos(2,2)
	name:SetText(self.name)
	local textinput = debugUI.loveframes.Create("textinput",panel)
	textinput:SetPos(10,20)
	textinput:SetSize(130,20)
	textinput:SetText(self.val)
	if not self.editable then
		textinput:SetEditable(false)
	end

	self.ui.panel = panel
	self.ui.name = name
	self.ui.textinput = textinput
	return self.ui.panel
end

return string