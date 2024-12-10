extends Node

@onready var audio_player = $AudioStreamPlayer

func _ready() -> void:
	# ボタンノードのシグナルを受け取る
	var button = get_node("Path/To/Button")  # ボタンノードのパスを指定
	button.connect("button_pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed() -> void:
	# 音を再生
	audio_player.play()
