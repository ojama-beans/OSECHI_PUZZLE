extends Control

@onready var background: ColorRect = $Background

func _ready() -> void:
	# 常時プロセスを有効化
	set_process_mode(Node2D.PROCESS_MODE_ALWAYS)
	hide_hud()  # HUDを初期状態で非表示にする
	SignalManager.on_game_complete.connect(on_game_complete)  # ゲーム完了時のシグナルに接続

# HUDを非表示
func hide_hud()-> void:
	background.visible = false

# HUDを表示
func show_hud()-> void:
	get_tree().paused = true  # ゲームを一時停止
	background.visible = true

# ゴール時に呼び出される関数
func on_game_complete()-> void:
	show_hud()