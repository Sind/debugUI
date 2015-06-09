function love.load()
	-- Load debugUI, by loading its folder.
	-- We are in the debugUI folder right now, so we use 'require "."'
	require "."
	test = {super = 3}

	-- Create debugUI windows
	ui = debugUI.new(
	{
		name = "Options",
		maxheight = 300,
		{	name = "sliders",
			{var = "test6", name = "print text", type = "checkbox"},
			{var = "test1", type = "slider", min = 0, max = 9999.99},
			{var = "test2", type = "slider", min = 0, max = 50},
			{var = "test3", type = "slider", name = "extra", min = 0, max = 100},
			{var = "test.super", type = "slider", min = 0, max = 100},
			{var = "test4", type = "slider", min = 0, max = 50},
			{var = "test5", type = "slider", min = 0, max = 100}
		},
		{	name = "checkboxes",
			{var = "test7", name = "testno", type = "checkbox" , val = true},
			{var = "test8", name = "rw", type = "checkbox", val = true},
			{var = "test9", name = "rw", type = "checkbox", val = false},
			{var = "test0", name = "qwt", type = "checkbox", val = false},
			{var = "testa", name = "qw", type = "checkbox", val = true},
			{var = "testb", name = "testc", type = "checkbox", val = true},
			{var = "testc", name = "testb", type = "checkbox", val = true}
		},
		{name = "angles", {var = "testinf", type = "angle", val = math.pi}},
		{name = "dropdowns",{var = "argh", type = "dropdown", vals = {"a","b","c"}}}
	})
	b = debugUI.new({var = "col", name = "background color", type="color"})
	col[2] = 100

	debugUI.hookCallbacks()
end

function love.update(dt)
	test.super = (test.super + 50*dt)%100
	love.graphics.setBackgroundColor(col)
	col[1] = (col[1] + 100*dt)%256
	-- testinf = testinf + dt*math.pi/5
end

function love.draw()
	if test6 then
		love.graphics.print(test1 .. " * " .. test2 .. " = " .. test1 * test2,300,300)
	end
	love.graphics.print("argh: " .. (argh or "[nil]"),300,340)
end

function love.keypressed(key, unicode)
	if key == "escape" then love.event.push("quit") end
end
