extends Area2D

signal placed_osechi_1

var _has_moved = false
var _drag_mode = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if _drag_mode:
		position = get_viewport().get_mouse_position()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if _has_moved:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_drag_mode = true
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			_drag_mode = false
			if on_grid():
				_has_moved = true
				snap_to_grid()
				place_on_grid()
				placed_osechi_1.emit()

func snap_to_grid() -> void:
	snap_to_grid_axis("x")
	snap_to_grid_axis("y")

func snap_to_grid_axis(axis: String) -> void:
	var mouse_pos = get_viewport().get_mouse_position()[axis]
	var pos = position[axis] - Global.origin[axis]
	var modded_pos = fmod(pos, Global.osechi_size)
	if modded_pos < (Global.osechi_size / 2):
		position[axis] = (int(mouse_pos - Global.origin[axis]) / Global.osechi_size) * Global.osechi_size + Global.origin[axis]
	else:
		position[axis] = ((int(mouse_pos - Global.origin[axis]) / Global.osechi_size) + 1) * Global.osechi_size + Global.origin[axis]

func on_grid() -> bool:
	var pos_on_grid = Vector2(position.x - Global.origin.x, position.y - Global.origin.y)
	var out_length = Global.osechi_size / 3
	return (-out_length <= pos_on_grid.x and pos_on_grid.x <= Global.grid_size + out_length) and (-out_length <= pos_on_grid.y and pos_on_grid.y <= Global.grid_size + out_length)

func place_on_grid() -> void:
	var pos_on_grid = Vector2i(position.x - Global.origin.x, position.y - Global.origin.y)
	pos_on_grid = Vector2i(pos_on_grid.x / Global.osechi_size, pos_on_grid.y / Global.osechi_size)
	const shape = Global.osechi_shape["Osechi_1"]
	for i in shape[0].size():
		for j in shape.size():
			Global.grid[pos_on_grid.y + i][pos_on_grid.x + j] = shape[i][j]
