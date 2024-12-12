extends Control

@onready var background: ColorRect = $Background
var button_sound = preload("res://.godot/imported/決定ボタンを押す44.mp3-7c669fdc170656b73228f68225242436.mp3str")
@onready var canvas_layer_node = $"../"

func _ready() -> void:
	# 常時プロセスを有効化
	set_process_mode(Node2D.PROCESS_MODE_ALWAYS)
	hide_hud()  # HUDを初期状態で非表示にする
	SignalManager.on_game_complete.connect(_on_game_complete)  # ゲーム完了時のシグナルに接続

# HUDを非表示
func hide_hud()-> void:
	canvas_layer_node.visible = false

# HUDを表示
func show_hud()-> void:
	get_tree().paused = true  # ゲームを一時停止
	canvas_layer_node.visible = true

# ゴール時に呼び出される関数
func _on_game_complete()-> void:
	show_hud()

func _on_back_button_pressed() -> void:
	var tree = get_tree()
	if tree != null:
		# シングルトンAudioPlayerで音を再生
		AudioStreamManeger.play_sound(button_sound)
		# 画面遷移
		tree.change_scene_to_file("res://scenes/home.tscn")
	else:
		print("Error: get_tree() returned null.")
