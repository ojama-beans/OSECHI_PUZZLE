extends Node

const osechi_num = 3
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
	# いくら
	"Osechi_1": [
		[2**0, 2**0], 
		[2**0, 2**0]
	],
	# 数の子
	"Osechi_2": [
		[2**1, 2**1]
	],
	# だて巻き
	"Osechi_3": [
		[0,    2**2], 
		[2**2, 2**2],
		[2**2,    0]
	],
}

var grid_size = osechi_size * grid.size()
var origin = Vector2i.ZERO
const timer = 60
const score = 5
const combo_map = {
	1: "None",
	2: "None",
	3: "None",
	4: "None",
	5: "None",
	6: "None",
	7: "sison_hanei",
}

var collision_diff = 4

func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	origin = Vector2i((screen_size.x - grid_size) / 2, (screen_size.y - grid_size) / 2)

func collision_shape(osechi_type: String) -> PackedVector2Array:
	var x_osechi = osechi_shape[osechi_type][0].filter(func(x): return x != 0).size() * osechi_size
	var y_osechi = osechi_shape[osechi_type].filter(func(array): return array[0] != 0).size() * osechi_size
	return PackedVector2Array([
		Vector2(0, 0),
		Vector2(0, -collision_diff),
		Vector2(x_osechi, -collision_diff),
		Vector2(x_osechi, 0),
		Vector2(x_osechi + collision_diff, 0), 
		Vector2(x_osechi + collision_diff, y_osechi),
		Vector2(x_osechi, y_osechi),
		Vector2(x_osechi, y_osechi + collision_diff),
		Vector2(0, y_osechi + collision_diff),
		Vector2(0, y_osechi),
		Vector2(-collision_diff, y_osechi),
		Vector2(-collision_diff, 0)
	])

func reset() -> void:
	for i in range(grid.size()):
		for j in range(grid[0].size()):
			grid[i][j] = 0
