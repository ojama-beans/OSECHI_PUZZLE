extends Control

var button_sound = preload("res://.godot/imported/決定ボタンを押す44.mp3-7c669fdc170656b73228f68225242436.mp3str")
var bgm=preload("res://assets/sounds/ことほぎ.mp3")

func _ready() -> void:
	AudioStreamManeger.play_bgm(bgm)

func _process(delta: float) -> void:
	pass

func _on_back_button_pressed() -> void:
	var tree = get_tree()
	if tree != null:
		# シングルトンAudioPlayerで音を再生
		AudioStreamManeger.play_sound(button_sound)
		# 画面遷移
		if tree.change_scene_to_file("res://scenes/home.tscn") == OK:
			print("Scene changed to home.tscn")
			AudioStreamManeger.play_bgm(bgm)  # ホーム画面に戻る際にBGMを再生
		else:
			print("Error: Failed to change scene to home.tscn")
	else:
		print("Error: get_tree() returned null.")


func _on_meaning_button_pressed() -> void:
	var tree = get_tree()
	if tree != null:
		# シングルトンAudioPlayerで音を再生
		AudioStreamManeger.play_sound(button_sound)
		# 画面遷移
		if tree.change_scene_to_file("res://scenes/meaning-oseti1.tscn") == OK:
			print("Scene changed to home.tscn")
			AudioStreamManeger.play_bgm(bgm)  
		else:
			print("Error: Failed to change scene to meaning-oseti.tscn")
	else:
		print("Error: get_tree() returned null.")