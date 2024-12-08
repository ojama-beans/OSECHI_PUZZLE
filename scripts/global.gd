extends Node

const osechi_size = 64
const can_place_puzzle = 1
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
		[1, 1], 
		[1, 1]
	],
}
const screen_size = Vector2i(720, 1280)
# grid_size is constant
var grid_size = osechi_size * grid[0].size()
var origin = Vector2i((screen_size.x - grid_size) / 2, (screen_size.y - grid_size) / 2)
