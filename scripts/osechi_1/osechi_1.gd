extends Area2D

signal placed_osechi_1

var _has_moved = false
var _drag_mode = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if _drag_mode:
		snap_to_grid()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if _has_moved:
		print("has moved")
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_drag_mode = true
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if on_grid(position):
				_has_moved = true
				_drag_mode = false
				place_on_grid()
				emit_signal("placed_osechi_1")

func snap_to_grid() -> void:
	var pos = position
	var mouse_pos = get_viewport().get_mouse_position()
	if on_grid(pos):
		snap_to_grid_axis("x", pos, mouse_pos)
		snap_to_grid_axis("y", pos, mouse_pos)
	else:
		position = mouse_pos

func snap_to_grid_axis(axis: String, pos_vector: Vector2, mouse_pos_vector: Vector2) -> void:
	var mouse_pos = mouse_pos_vector[axis]
	var pos = pos_vector[axis] - Global.origin[axis]
	print("orgnl = ", position)
	print("moved = ", pos, ", axis= ", axis)
	if fmod(pos, Global.osechi_size) < (Global.osechi_size / 4):
		position[axis] = (int(mouse_pos) / Global.osechi_size) * Global.osechi_size + Global.origin[axis]
	elif fmod(pos, Global.osechi_size) >= (Global.osechi_size * 3 / 4):
		position[axis] = ((int(mouse_pos) / Global.osechi_size) + 1) * Global.osechi_size + Global.origin[axis]
	else:
		position[axis] = mouse_pos

func on_grid(pos: Vector2) -> bool:
	var pos_on_grid = Vector2i(pos.x - Global.origin.x, pos.y - Global.origin.y)
	return (0 <= pos_on_grid.x and pos_on_grid.x <= Global.grid_size) and (0 <= pos_on_grid.y and pos_on_grid.y <= Global.grid_size)

func place_on_grid() -> void:
	var pos_on_grid = Vector2i(position.x - Global.origin.x, position.y - Global.origin.y)
	pos_on_grid = Vector2i(pos_on_grid.x % Global.osechi_size, pos_on_grid.y % Global.osechi_size)
	const shape = Global.osechi_shape["Osechi_1"]
	for i in shape[0].size():
		for j in shape.size():
			Global.grid[pos_on_grid.x + i][pos_on_grid.y + j] = shape[i][j]
	print(Global.grid)
