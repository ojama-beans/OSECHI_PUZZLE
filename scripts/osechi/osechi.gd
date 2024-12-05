extends Area2D

var _drag_mode = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if _drag_mode:
		var mouse_pos = get_viewport().get_mouse_position()
		position = mouse_pos
	pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_drag_mode = true
		else:
			_drag_mode = false

	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)
