extends Area2D

signal placed_osechi_1

var _drag_mode = false
var _on_grid = false
const _shape = Global.osechi_shape["Osechi_1"]
var _prev_pos = Vector2()
var _diff = Vector2()
const _return_speed = 1000

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if _drag_mode:
		position = get_viewport().get_mouse_position() - _diff
	elif _on_grid:
		if overlap():
			move_towards(_prev_pos, delta * _return_speed)
		else:
			snap_to_grid()
			place_on_grid()
			placed_osechi_1.emit()
			set_process_input(false)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not _drag_mode:
				_prev_pos = position
				_diff = get_viewport().get_mouse_position() - position
			_drag_mode = true
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			_drag_mode = false
			if on_grid():
				_on_grid = true

func snap_to_grid() -> void:
	snap_to_grid_axis("x")
	snap_to_grid_axis("y")

func snap_to_grid_axis(axis: String) -> void:
	var mouse_pos = get_viewport().get_mouse_position()[axis]
	var pos = position[axis] - Global.origin[axis]
	var modded_pos = fmod(pos, Global.osechi_size)
	var ratio_on_grid
	if modded_pos < (Global.osechi_size / 2):
		ratio_on_grid = int(mouse_pos - Global.origin[axis]) / Global.osechi_size
	else:
		ratio_on_grid = (int(mouse_pos - Global.origin[axis]) / Global.osechi_size) + 1
	position[axis] = ratio_on_grid * Global.osechi_size + Global.origin[axis]

func on_grid() -> bool:
	var pos_on_grid = Vector2(position.x - Global.origin.x, position.y - Global.origin.y)
	var grid_end = Global.grid_size - _shape[0].size()
	var out_length = Global.osechi_size / 3
	return ((-out_length <= pos_on_grid.x and pos_on_grid.x <= grid_end + out_length) and
			(-out_length <= pos_on_grid.y and pos_on_grid.y <= grid_end + out_length))

func place_on_grid() -> void:
	var pos_on_grid = Vector2i(position.x - Global.origin.x, position.y - Global.origin.y)
	pos_on_grid = Vector2i(pos_on_grid.x / Global.osechi_size, pos_on_grid.y / Global.osechi_size)
	for i in _shape[0].size():
		for j in _shape.size():
			Global.grid[pos_on_grid.y + i][pos_on_grid.x + j] = _shape[i][j]
	print(Global.grid)
