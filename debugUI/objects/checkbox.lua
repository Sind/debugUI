local checkbox = loveframes.class('checkbox')

function checkbox:initialize(k,v)
	self.var = k
	self.val = _G[k] or v[2] or true
	_G[k] = self.val
	
end