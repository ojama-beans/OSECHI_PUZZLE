extends Area2D

signal placed_osechi_1
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
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			_drag_mode = false
			place_on_grid()
			emit_signal("placed_osechi_1")

func snap_to_grid(axis: String):
	var mouse_pos = get_viewport().get_mouse_position()[axis]
	if fmod(position[axis], Global.osechi_size) < (Global.osechi_size / 4):
		position[axis] = (int(mouse_pos) / Global.osechi_size) * Global.osechi_size
	elif fmod(position[axis], Global.osechi_size) >= (Global.osechi_size * 3 / 4):
		position[axis] = ((int(mouse_pos) / Global.osechi_size) + 1) * Global.osechi_size
	else:
		position[axis] = mouse_pos

func place_on_grid() -> void:
	# ここにパズルを配置する処理を書く
	pass
