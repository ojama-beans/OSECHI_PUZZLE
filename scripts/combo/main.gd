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
	if Global.combo_map.get(combo, "None") != "None":
		canvas_layer_node.visible = true
		Score.combo()
		combo_effct(combo)

func _on_video_finished() -> void:
	canvas_layer_node.visible = false
	SignalManager.combo_ended.emit()

func combo_effct(combo: int) -> void:
	if Global.combo_map[combo] == "sison_hanei":
		var video_stream_player_node = $VideoStreamPlayer
	if Global.combo_map[combo] == "kenko_tyoju":
		var video_stream_player_node = $VideoStreamPlayer
	video_stream_player_node.finished.connect(_on_video_finished)
	video_stream_player_node.play()
