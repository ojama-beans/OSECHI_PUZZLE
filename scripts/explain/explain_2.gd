extends Control

# 再生する音を指定
var button_sound = preload("res://.godot/imported/和太鼓でドドン.mp3-6c70c347e28623d8cb4d13c130ae58e9.mp3str")

func _on_back_button_pressed() -> void:
	var tree = get_tree()
	if tree != null:
		# シングルトンAudioPlayerで音を再生
		AudioStreamManeger.play_sound(button_sound)
		# 画面遷移
		tree.change_scene_to_file("res://scenes/home.tscn")
	else:
		print("Error: get_tree() returned null.")
