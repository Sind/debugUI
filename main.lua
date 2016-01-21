

function love.load()
	-- Load debugUI, by loading its folder.
	-- We are in the debugUI folder right now, so we use 'require "."'
	require "."
	test = {super = 3}

	-- Create debugUI windows
	ui = debugUI.new(
	{
		{	name = "sliders",
			{var = "test6", name = "print text", type = "checkbox"},
			{tooltip = "slider tooltip", var = "test1", type = "slider", min = 0, max = 9999.99},
			{var = "test2", type = "slider", min = 0, max = 50},
			{var = "test3", type = "slider", name = "extra", min = 0, max = 100},
			{var = "test.super", type = "slider", min = 0, max = 100},
			{var = "test4", type = "slider", min = 0, max = 50},
			{var = "test5", type = "slider", min = 0, max = 100}
		},
		{	name = "checkboxes",
			{tooltip = "checkbox tooltip",var = "test7", name = "testno", type = "checkbox" , val = true},
			{var = "test8", name = "rw", type = "checkbox", val = true},
			{var = "test9", name = "rw", type = "checkbox", val = false},
			{var = "test0", name = "qwt", type = "checkbox", val = false},
			{var = "testa", name = "qw", type = "checkbox", val = true},
			{var = "testb", name = "testc", type = "checkbox", val = true},
			{var = "testc", name = "testb", type = "checkbox", val = true}
		},
		{name = "angles",
			{tooltip= "angle tooltip",var = "testinf", type = "angle", val = math.pi},
			{tooltip= "vector tooltip",var = "testvec",val = {0,1},type = "vector",r=500}
		},
		{name = "dropdowns",{tooltip = "dropdown tooltip",var = "argh", type = "dropdown", vals = {"a","b","c"}}},
		{name = "strings",
			{tooltip = "string tooltip",var = "string1", type = "string", val = "hey"},
			{var = "string2", type = "string", val = "a", editable = false}
		}
	
	},
	{maxheight=300})
	b = debugUI.new({var = "col", name = "background color", type="color", tooltip = 
[[really long color tooltip that I am cutting
up into three lines to avoid it going out of
the screen or being uncomfortable to read]]},
	                {name = "Single Option",minimized = true})
	col[2] = 100
	debugUI.new({var = "whatever",name = "whatever", type="checkbox"},{minheight=0})

	debugUI.hookCallbacks()

	rotstrings = {"a", "b", "c"}
	roti = 1
	rotacc = 0
end

function love.update(dt)
	test.super = (test.super + 50*dt)%100
	love.graphics.setBackgroundColor(col)
	col[1] = (col[1] + 100*dt)%256
	rotacc = rotacc + dt
	while rotacc > 1 do
		rotacc = rotacc - 1
		roti = roti + 1
		if roti == 4 then roti = 1 end
		string2 = rotstrings[roti]
	end
	-- testinf = testinf + dt*math.pi/5
end

function love.draw()
	if test6 then
		love.graphics.print(test1 .. " * " .. test2 .. " = " .. test1 * test2,300,300)
	end
	love.graphics.print("argh: " .. (argh or "[nil]"),300,340)
	love.graphics.print(string1 .. string2, 300, 400)
end

function love.keypressed(key, unicode)
	if key == "escape" then love.event.push("quit") end
end
