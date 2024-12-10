extends Control

# 再生する音を指定
var button_sound = preload("res://.godot/imported/決定ボタンを押す44.mp3-7c669fdc170656b73228f68225242436.mp3str")
var bgm=preload("res://assets/sounds/ことほぎ.mp3")

func  _ready():
	AudioStreamManeger.play_bgm(bgm)	

func _on_explan_button_pressed() -> void:
	var tree = get_tree()
	if tree != null:
		# シングルトンAudioPlayerで音を再生
		AudioStreamManeger.play_sound(button_sound)  
		tree.change_scene_to_file("res://scenes/explain1.tscn")
	else:
		print("Error: get_tree() returned null.")

func _on_start_button_pressed() -> void:
	var tree = get_tree()
	if tree != null:
		# シングルトンAudioPlayerで音を再生
		AudioStreamManeger.play_sound(button_sound)  
		AudioStreamManeger.stop_bgm()
		tree.change_scene_to_file("res://scenes/game.tscn")
	else:
		print("Error: get_tree() returned null.")

