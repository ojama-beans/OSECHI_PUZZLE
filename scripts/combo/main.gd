extends Node

@onready var canvas_layer_node = $"../"

@onready var timer_node = $"../../Timer"

@onready var video_stream_player_node = $VideoStreamPlayer

func _ready() -> void:
	SignalManager.combo_occurred.connect(_on_combo_occurred)
	canvas_layer_node.visible = false

func _process(delta: float) -> void:
	pass

func _on_combo_occurred(combo: int) -> void:
	canvas_layer_node.visible = true
	Score.combo()
	combo_effct(combo)

func _on_video_finished() -> void:
	timer_node.paused = false
	canvas_layer_node.visible = false

func combo_effct(combo: int) -> void:
	timer_node.paused = true
	# combo id に応じて再生するファイルを決める
	if combo == (2**0 | 2**1 | 2**2):
		video_stream_player_node.finished.connect(_on_video_finished)
		video_stream_player_node.play()
