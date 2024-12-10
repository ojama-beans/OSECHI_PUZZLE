extends Area2D

signal placed_osechi_1(placed: Vector2i, id: String)

var _drag_mode = false
var _on_grid = false
const _shape = Global.osechi_shape["Osechi_1"]
var _before_move = Vector2.ZERO
var _diff = Vector2.ZERO
const _return_speed = 10

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if _drag_mode:
		position = get_viewport().get_mouse_position() - _diff
	elif _on_grid:
		var snapped_pos = snap_to_grid()
		if overlap(snapped_pos):
			position = _before_move
			_on_grid = false
		else:
			position = snapped_pos
			place_on_grid()
			placed_osechi_1.emit(position, "Osechi_1")
			set_process(false)
			set_process_input(false)
		
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is not InputEventMouseButton:
		return
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not _drag_mode:
			_before_move = position
			_diff = get_viewport().get_mouse_position() - position
			_drag_mode = true
	elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		_drag_mode = false
		if on_grid():
			_on_grid = true

func overlap(snapped_pos: Vector2) -> bool:
	var pos_as_index = (Vector2i(snapped_pos) - Global.origin) / Global.osechi_size
	for i in _shape[0].size():
		for j in _shape.size():
			if _shape[i][j] != 0 and Global.grid[pos_as_index.y + i][pos_as_index.x + j] != 0:
				return true
	return false

func snap_to_grid() -> Vector2:
	var snapped_pos = Vector2.ZERO
	for axis in ["x", "y"]:
		var mouse_pos = get_viewport().get_mouse_position()[axis] - _diff[axis]
		var pos = position[axis] - Global.origin[axis]
		var modded_pos = fmod(pos, Global.osechi_size)
		var ratio_on_grid
		if modded_pos < (Global.osechi_size / 2):
			ratio_on_grid = int(mouse_pos - Global.origin[axis]) / Global.osechi_size
		else:
			ratio_on_grid = (int(mouse_pos - Global.origin[axis]) / Global.osechi_size) + 1
		snapped_pos[axis] = ratio_on_grid * Global.osechi_size + Global.origin[axis]
	return snapped_pos

func on_grid() -> bool:
	var pos_on_grid = position - Vector2(Global.origin)
	var grid_end = Global.grid_size - _shape[0].size()
	var out_length = Global.osechi_size / 3
	return ((-out_length <= pos_on_grid.x and pos_on_grid.x <= grid_end + out_length) and
			(-out_length <= pos_on_grid.y and pos_on_grid.y <= grid_end + out_length))

func place_on_grid() -> void:
	var pos_as_index = (Vector2i(position) - Global.origin) / Global.osechi_size
	for i in _shape[0].size():
		for j in _shape.size():
			Global.grid[pos_as_index.y + i][pos_as_index.x + j] = _shape[i][j]
