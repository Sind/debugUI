

function love.load()
	require "debugUI"
	test = {super = 3}
	ui = debugUI.new(
	{
		test1 = {"slider",0,100},
		test2 = {"slider", 0, 50},
		["test.super"] = {"slider", 0, 100},
		test3 = {"slider",0,100},
		test4 = {"slider", 0, 50},
		test5 = {"slider",0,100},
		test6 = {"slider", 0, 50}
	})
	b = debugUI.new({abc = {"slider",0,100}})
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