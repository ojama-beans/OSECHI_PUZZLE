extends Button

func _ready():
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	# ゲーム画面への遷移
	get_tree().change_scene_to_file("res://scenes/game_screen.tscn")
	
