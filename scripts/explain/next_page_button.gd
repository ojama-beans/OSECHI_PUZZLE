extends Button

@onready var audio_player = $AudioStreamPlayer

func _ready() -> void:
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed() -> void:
	# ゲーム画面への遷移
	audio_player.play()
	get_tree().change_scene_to_file("res://scenes/explain2.tscn")
