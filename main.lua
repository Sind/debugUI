

function love.load()
	require "debugUI"
	test = {super = 3}
	ui = debugUI.new(
	{
		{var = "test1", type = "slider", min = 0, max = 9999.99},
		{var = "test2", type = "slider", min = 0, max = 50},
		{var = "test3", type = "slider", name = "extra", min = 0, max = 100},
		{var = "test.super", type = "slider", min = 0, max = 100},
		{var = "test4", type = "slider", min = 0, max = 50},
		{var = "test5", type = "slider", min = 0, max = 100},
		{var = "test6", type = "slider", min = 0, max = 100}
	})
	b = debugUI.new({{var = "abc", type = "slider",min = 0, max =100}})
end

function love.update(dt)
	debugUI.update(dt)
	test.super = (test.super + 50*dt)%100
end

function love.draw()
	love.graphics.print(test1 .. " * " .. test2 .. " = " .. test1 * test2,300,300)
	debugUI.draw()
end

function love.mousepressed(x, y, button)
	debugUI.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	debugUI.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	if key == "escape" then love.event.push("quit") end
	debugUI.keypressed(key, unicode)
end

function love.keyreleased(key)
	debugUI.keyreleased(key)
end