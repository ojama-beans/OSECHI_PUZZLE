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

var collision_diff = 4
var x_osechi_1 = osechi_shape["Osechi_1"][0].size() * osechi_size
var y_osechi_1 = osechi_shape["Osechi_1"].size() * osechi_size
var x_osechi_2 = osechi_shape["Osechi_2"][0].size() * osechi_size
var y_osechi_2 = osechi_shape["Osechi_2"].size() * osechi_size
var collision_shape = {
	# いくら
	"Osechi_1": PackedVector2Array([
		Vector2(0, 0),
		Vector2(0, -collision_diff),
		Vector2(x_osechi_1, -collision_diff),
		Vector2(x_osechi_1, 0),
		Vector2(x_osechi_1 + collision_diff, 0), 
		Vector2(x_osechi_1 + collision_diff, y_osechi_1),
		Vector2(x_osechi_1, y_osechi_1),
		Vector2(x_osechi_1, y_osechi_1 + collision_diff),
		Vector2(0, y_osechi_1 + collision_diff),
		Vector2(0, y_osechi_1),
		Vector2(-collision_diff, y_osechi_1),
		Vector2(-collision_diff, 0)
	]),
	# 数の子
	"Osechi_2": PackedVector2Array([
		Vector2(0, 0),
		Vector2(0, -collision_diff),
		Vector2(x_osechi_2, -collision_diff),
		Vector2(x_osechi_2, 0),
		Vector2(x_osechi_2 + collision_diff, 0), 
		Vector2(x_osechi_2 + collision_diff, y_osechi_2),
		Vector2(x_osechi_2, y_osechi_2),
		Vector2(x_osechi_2, y_osechi_2 + collision_diff),
		Vector2(0, y_osechi_2 + collision_diff),
		Vector2(0, y_osechi_2),
		Vector2(-collision_diff, y_osechi_2),
		Vector2(-collision_diff, 0)
	]),
	# だて巻き
	"Osechi_3": PackedVector2Array([
		Vector2(osechi_size,  -collision_diff),
		Vector2(osechi_size * 2,  -collision_diff),
		Vector2(osechi_size * 2,  0),
		Vector2(osechi_size * 2 + collision_diff,  0),
		Vector2(osechi_size * 2 + collision_diff,  osechi_size * 2),
		Vector2(osechi_size * 2,  osechi_size * 2),
		Vector2(osechi_size * 2,  osechi_size * 2 + collision_diff),
		Vector2(osechi_size + collision_diff,  osechi_size * 2 + collision_diff),
		Vector2(osechi_size + collision_diff,  osechi_size * 3),
		Vector2(osechi_size,  osechi_size * 3),
		Vector2(osechi_size,  osechi_size * 3 + collision_diff),
		Vector2(0, osechi_size * 3 + collision_diff),
		Vector2(0, osechi_size * 3),
		Vector2(-collision_diff, osechi_size * 3),
		Vector2(-collision_diff, osechi_size),
		Vector2(0, osechi_size),
		Vector2(0, osechi_size - collision_diff),
		Vector2(osechi_size - collision_diff, osechi_size - collision_diff),
		Vector2(osechi_size - collision_diff,  0),
		Vector2(osechi_size,  0)
	])
}

func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	origin = Vector2i((screen_size.x - grid_size) / 2, (screen_size.y - grid_size) / 2)
