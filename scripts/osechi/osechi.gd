extends Area2D

var _drag_mode = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if _drag_mode:
		snap_to_grid("x")
		snap_to_grid("y")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_drag_mode = true
		else:
			_drag_mode = false

	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)

func snap_to_grid(axis: String):
	var mouse_pos = get_viewport().get_mouse_position()
	var pos = position[axis]
	if fmod(pos, Grobal.osechi_size) < (Grobal.osechi_size / 4):
		position[axis] = (int(mouse_pos[axis]) / Grobal.osechi_size) * Grobal.osechi_size
	elif fmod(pos, Grobal.osechi_size) >= (Grobal.osechi_size * 3 / 4):
		position[axis] = ((int(mouse_pos[axis]) / Grobal.osechi_size) + 1) * Grobal.osechi_size
	else:
		position[axis] = mouse_pos[axis]
