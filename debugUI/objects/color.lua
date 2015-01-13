local color = debugUI.loveframes.class('color')

color.initialize = function(self,v)
	self.var = v.var
	self.name = v.name or self.var
	self.val = {}
	local orval = debugUI.getfield(self.var)
	self.val.r = (v.val and v.val[1]) or (orval and orval[1]) or 255
	self.val.g = (v.val and v.val[2]) or (orval and orval[2]) or 255
	self.val.b = (v.val and v.val[3]) or (orval and orval[3]) or 255
	self.val.a = (v.val and v.val[4]) or (orval and orval[4]) or 255
	debugUI.setfield(self.var,{selv.val.r,self.val.g,self.val.b,self.val.a})
end

return color