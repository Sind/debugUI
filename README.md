debugUI
=======

debugUI library for use with the LÖVE framework

**still in early development; many features are missing.**


Usage
-----

This section is not yet complete; for now, check `main.lua` for examples.

Modules
-------
### slider
For use with a number with a continuous range.
#### inputs
	*var: name of variable
	name: name of the module instance
		defaults to variable name
	val: initial value of the variable
		defaults to value of the variable at the time of creation, if it exists. If not, defaults to minimum valid value
	min: minimum valid value to define the range of the slider
		defaults to '0'
	max: maximum valid value to define the range of the slider
		defaults to '1'

### checkbox
For use with a boolean variable.
#### inputs
	*var: name of variable
	name: name of the module instance
		defaults to variable name
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to 'false'

### dropdown
For use with a string with a set of valid values.
#### inputs
	*var: name of variable
	name: name of module instance
		defaults to variable name
	*vals: list of valid strings.
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to 'nil'

### color
For use with a color value(table with 4 variables {r,g,b,a})
#### inputs
	*var: name of variable
	name: name of module instance
		defaults to variable name
	val: initial value of the variable
		defaults to the value of the variable at the time of creating, if it exists. If not, defaults to '{255,255,255,255}'

### angle
For use with an angle in radians from 0 to 2*pi
#### inputs
	*var: name of the variable
	name: name of the module instance
		defaults to variable name
	val: initial value of the variable
	defaults to the value of the variable at the time of creating, if it exists. If not, defaults to '0'

---

Created by Srod Karim

This library uses the following third party libraries:

Löve Frames by Kenny Shields: https://github.com/KennyShields/LoveFrames
middleclass by kikito: https://github.com/kikito/middleclass