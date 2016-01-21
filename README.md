debugUI
=======

debugUI library for use with the LÖVE framework

**still in early development; many features are missing.**


Usage
-----

*This section is not yet complete; for now, check `main.lua` for examples.*

To use debugUI, make sure you have the following calls:

either
	function love.load()
		require "[path to debugUI folder]"
	end
	function love.update(dt)
		debugUI.update(dt)
	end
	function love.draw()
		debugUI.draw()
	end
	function love.mousepressed(x, y, button, istouch)
		debugUI.mousepressed(x, y, button, istouch)
	end
	function love.mousereleased(x, y, button, istouch)
		debugUI.mousereleased(x, y, button, istouch)
	end
	function love.keypressed(key, scancode, isrepeat)
		debugUI.keypressed(key, scancode, isrepeat)
	end
	function love.keyreleased(key, scancode)
		debugUI.keyreleased(key,scancode)
	end
	function love.textinput(text)
		debugUI.textinput(text)
	end
or
	function love.load()
		require "[path to debugUI folder]"
		debugUI.hookCallbacks
	end

then, create debugUI windows using 
	debugUI.new([instances],[options])

[instances] is a table that describes what ojects the debugUI window should contain.
[options] is a table that describes properties of the window itself.

Instances table
---------------

Options table
-------------
Here is a list of all options:

####name:
Name of the window
	defaults to "Options"

####minheight:
Minimum height of the window
	defaults to '0'

####maxheight
Maximum height of the window
	defaults to '400'

###minimized
If the window should start of minimized
	defaults to 'false'

Modules
-------
### slider
For use with a number with a continuous range.
##### inputs
	*var: name of variable
	name: name of the module instance
		defaults to variable name
	val: initial value of the variable
		defaults to value of the variable at the time of creation, if it exists. If not, defaults to minimum valid value
	min: minimum valid value to define the range of the slider
		defaults to '0'
	max: maximum valid value to define the range of the slider
		defaults to '1'
	tooltip: string to display when hovering over the module instance
		defaults to no tooltip

### checkbox
For use with a boolean variable.
##### inputs
	*var: name of variable
	name: name of the module instance
		defaults to variable name
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to 'false'
	tooltip: string to display when hovering over the module instance
		defaults to no tooltip

### string
For use with arbitrary strings, or printing a string out
##### inputs
	*var: name of variable
	name: name of module instance
		defaults to variable name
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to empty string ""
	editable: whether the user can use the debugUI module instance to edit the string or not. Use this to print a string to the user, that they cannot edit
		defaults to true
	tooltip: string to display when hovering over the module instance
		defaults to no tooltip

### dropdown
For use with a string with a set of valid values.
##### inputs
	*var: name of variable
	name: name of module instance
		defaults to variable name
	*vals: list of valid strings.
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to 'nil'
	tooltip: string to display when hovering over the module instance
		defaults to no tooltip

### color
For use with a color value(table with 4 variables {r,g,b,a})
##### inputs
	*var: name of variable
	name: name of module instance
		defaults to variable name
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to '{255,255,255,255}'
	tooltip: string to display when hovering over the module instance
		defaults to no tooltip

### angle
For use with an angle in radians from 0 to 2*pi
##### inputs
	*var: name of the variable
	name: name of the module instance
		defaults to variable name
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to '0'
	tooltip: string to display when hovering over the module instance
		defaults to no tooltip

### angle
For use with 2d vectors in 
##### inputs
	*var: name of the variable
	name: name of the module instance
		defaults to variable name
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to '{1,0}'
	r: max length of the vector
		defaults to '1'
	tooltip: string to display when hovering over the module instance
		defaults to no tooltip


### New Modules
You can make new modules yourself. the slider.lua file in the "objects" subfolder explains how modules work.

Also, feel free to request new modules in the debugUI issue tracker.

---

Created by Srod Karim

This library uses the following third party libraries:

Löve Frames by Kenny Shields: https://github.com/KennyShields/LoveFrames
middleclass by kikito: https://github.com/kikito/middleclass