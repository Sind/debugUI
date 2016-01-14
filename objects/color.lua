local color = debugUI.loveframes.class('color')

color.initialize = function(self,v)
	self.var = v.var
	self.name = v.name or self.var
	self.height = 240
	self.val = {}
	local orval = debugUI.getfield(self.var)
	self.val.r = (v.val and v.val[1]) or (orval and orval[1]) or 255
	self.val.g = (v.val and v.val[2]) or (orval and orval[2]) or 255
	self.val.b = (v.val and v.val[3]) or (orval and orval[3]) or 255
	self.val.a = (v.val and v.val[4]) or (orval and orval[4]) or 255
	self.tooltip = v.tooltip

	debugUI.setfield(self.var,{self.val.r,self.val.g,self.val.b,self.val.a})
end

color.update = function(self)
	local oldGlobal = debugUI.getfield(self.var)
	local oldUI = {self.ui.rslider:GetValue(),self.ui.gslider:GetValue(),self.ui.bslider:GetValue(),self.ui.aslider:GetValue()}
	if oldUI[1] ~= self.val.r or oldUI[2] ~= self.val.g or oldUI[3] ~= self.val.b or oldUI[4] ~= self.val.a then
		self.val.r = oldUI[1]
		self.val.g = oldUI[2]
		self.val.b = oldUI[3]
		self.val.a = oldUI[4]
		debugUI.setfield(self.var,{self.val.r,self.val.g,self.val.b,self.val.a})
	elseif oldGlobal[1] ~= self.val.r or oldGlobal[2] ~= self.val.g or oldGlobal[3] ~= self.val.b or oldGlobal[4] ~= self.val.a then
		self.val.r = math.floor(oldGlobal[1])
		self.val.g = math.floor(oldGlobal[2])
		self.val.b = math.floor(oldGlobal[3])
		self.val.a = math.floor(oldGlobal[4])
		self.ui.rslider:SetValue(self.val.r)
		self.ui.gslider:SetValue(self.val.g)
		self.ui.bslider:SetValue(self.val.b)
		self.ui.aslider:SetValue(self.val.a)
	end
		self.ui.rval:SetText(self.val.r)
		self.ui.gval:SetText(self.val.g)
		self.ui.bval:SetText(self.val.b)
		self.ui.aval:SetText(self.val.a)
end

color.setup = function(self)
	self.ui = {}

	local panel = debugUI.loveframes.Create("panel")
	panel:SetSize(150,240)

	local name = debugUI.loveframes.Create("text",panel)
	name:SetPos(2,2)
	name:SetText(self.name)
	
	local cpanel = debugUI.loveframes.Create("panel",panel)
	cpanel:SetPos(5,20)
	cpanel:SetSize(145,38)
	cpanel.link = self
	cpanel.Draw = function(object)
		local pcr, pcg, pcb, pca = love.graphics.getColor();
		love.graphics.setColor(object.link.val.r,object.link.val.g,object.link.val.b,object.link.val.a)
		love.graphics.rectangle("fill",object:GetX(),object:GetY(),object:GetWidth(),object:GetHeight())
		love.graphics.setColor(143, 143, 143, 255)
		love.graphics.rectangle("line", object:GetX(), object:GetY(), object:GetWidth(), object:GetHeight())
		love.graphics.setColor(pcr, pcg, pcb, pca)
	end
	local rslider = debugUI.loveframes.Create("slider",panel)
	rslider:SetHeight(130)
	rslider:SetMinMax(0,255)
	rslider:SetSlideType("vertical")
	rslider:SetButtonSize(20,10)
	rslider:SetValue(self.val.r)
	rslider:SetPos(5,80)
	rslider:SetDecimals(0)
	local rtext = debugUI.loveframes.Create("text",panel)
	rtext:SetText("r")
	rtext:SetPos(12,60)
	local rval = debugUI.loveframes.Create("text",panel)
	rval:SetText(self.val.r)
	rval:SetPos(5,220)

	local gslider = debugUI.loveframes.Create("slider",panel)
	gslider:SetHeight(130)
	gslider:SetMinMax(0,255)
	gslider:SetSlideType("vertical")
	gslider:SetButtonSize(20,10)
	gslider:SetValue(self.val.g)
	gslider:SetPos(45,80)
	gslider:SetDecimals(0)
	local gtext = debugUI.loveframes.Create("text",panel)
	gtext:SetText("g")
	gtext:SetPos(52,60)
	local gval = debugUI.loveframes.Create("text",panel)
	gval:SetText(self.val.g)
	gval:SetPos(45,220)

	local bslider = debugUI.loveframes.Create("slider",panel)
	bslider:SetHeight(130)
	bslider:SetMinMax(0,255)
	bslider:SetSlideType("vertical")
	bslider:SetButtonSize(20,10)
	bslider:SetValue(self.val.b)
	bslider:SetPos(85,80)
	bslider:SetDecimals(0)
	local btext = debugUI.loveframes.Create("text",panel)
	btext:SetText("b")
	btext:SetPos(92,60)
	local bval = debugUI.loveframes.Create("text",panel)
	bval:SetText(self.val.b)
	bval:SetPos(85,220)

	local aslider = debugUI.loveframes.Create("slider",panel)
	aslider:SetHeight(130)
	aslider:SetMinMax(0,255)
	aslider:SetSlideType("vertical")
	aslider:SetButtonSize(20,10)
	aslider:SetValue(self.val.a)
	aslider:SetPos(125,80)
	aslider:SetDecimals(0)
	local atext = debugUI.loveframes.Create("text",panel)
	atext:SetText("a")
	atext:SetPos(132,60)
	local aval = debugUI.loveframes.Create("text",panel)
	aval:SetText(self.val.a)
	aval:SetPos(123,220)

	self.ui.panel = panel
	self.ui.cpanel = cpanel
	self.ui.rslider = rslider
	self.ui.gslider = gslider
	self.ui.bslider = bslider
	self.ui.aslider = aslider
	self.ui.rtext = rtext
	self.ui.gtext = gtext
	self.ui.btext = btext
	self.ui.atext = atext
	self.ui.rval = rval
	self.ui.gval = gval
	self.ui.bval = bval
	self.ui.aval = aval

	return self.ui.panel
end


return color