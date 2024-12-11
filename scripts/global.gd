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

var collision = 8
var non_overlap_length = 4
var collision_shape = PackedVector2Array([
	Vector2(overlap_length, -overlap_length),
	Vector2(osechi_size - overlap_length, -overlap_length),
	Vector2(osechi_size - overlap_length, overlap_length),
	Vector2(osechi_size + overlap_length, overlap_length),
	Vector2(osechi_size + overlap_length, osechi_size - overlap_length),
	Vector2(osechi_size - overlap_length, osechi_size - overlap_length),
	Vector2(osechi_size - overlap_length, osechi_size + overlap_length),
	Vector2(overlap_length, osechi_size + overlap_length),
	Vector2(overlap_length, osechi_size - overlap_length),
	Vector2(-overlap_length, osechi_size - overlap_length),
	Vector2(-overlap_length, overlap_length),
	Vector2(overlap_length, overlap_length)
])

func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	origin = Vector2i((screen_size.x - grid_size) / 2, (screen_size.y - grid_size) / 2)
