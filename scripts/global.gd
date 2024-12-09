extends Node

const osechi_size = 64
const can_place_osechi = 1
var grid = [
		[0, 0, 0, 0, 0, 0, 0, 0], 
		[0, 0, 0, 0, 0, 0, 0, 0], 
		[0, 0, 0, 0, 0, 0, 0, 0], 
		[0, 0, 0, 0, 0, 0, 0, 0], 
		[0, 0, 0, 0, 0, 0, 0, 0], 
		[0, 0, 0, 0, 0, 0, 0, 0], 
		[0, 0, 0, 0, 0, 0, 0, 0], 
		[0, 0, 0, 0, 0, 0, 0, 0]
]
const osechi_shape = {
	"Osechi_1": [
		[2**0, 2**0], 
		[2**0, 2**0]
	],
}
const screen_size = Vector2i(720, 1280)
var grid_size = osechi_size * grid.size()
var origin = Vector2i((screen_size.x - grid_size) / 2, (screen_size.y - grid_size) / 2)
const timer = 60
const score = 5