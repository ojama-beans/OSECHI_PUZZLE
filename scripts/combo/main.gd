extends Node

@onready var game_node = $"../../"

@onready var canvas_layer_node = $"../"

@onready var timer_node = $"../../Timer"

@onready var video_stream_player_node = $VideoStreamPlayer

func _ready() -> void:
	game_node.connect("combo_occurred", Callable(self, "_on_combo_occurred"))
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
	video_stream_player_node.connect("finished", Callable(self, "_on_video_finished"))
	video_stream_player_node.play()
