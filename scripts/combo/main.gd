extends Node

@onready var game_node = get_parent()

func _ready() -> void:
	game_node.connect("combo_occurred", Callable(self, "_on_combo_occurred"))

func _process(delta: float) -> void:
	pass

func _on_combo_occurred(combo: int) -> void:
	print("combo")
	pass
