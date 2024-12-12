extends Node

signal time_over()
signal cannot_place_osechi()
signal combo_occurred(combo: int)
signal combo_ended()
signal on_game_complete()

func _ready() -> void:
	time_over.connect(_on_game_over)
	cannot_place_osechi.connect(_on_game_over)

func _process(delta: float) -> void:
	pass

func _on_game_over() -> void:
	on_game_complete.emit()
