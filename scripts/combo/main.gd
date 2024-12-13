extends Node

@onready var canvas_layer_node = $"../"

@onready var video_sison_hanei = $SisonHanei

@onready var video_kenko_tyoju = $KenkoTyoju

func _ready() -> void:
	SignalManager.combo_occurred.connect(_on_combo_occurred)
	canvas_layer_node.visible = false

func _process(delta: float) -> void:
	pass

func _on_combo_occurred(combo: int) -> void:
	if Global.check_any_combo_map(combo):
		canvas_layer_node.visible = true
		Score.combo()
		combo_effct(combo)

func _on_video_finished() -> void:
	canvas_layer_node.visible = false
	SignalManager.combo_ended.emit()

func combo_effct(combo: int) -> void:
	if Global.partial_match(combo, Global.combo_map.SISON_HANEI):
		video_sison_hanei.finished.connect(_on_video_finished)
		video_sison_hanei.play()
	elif Global.partial_match(combo, Global.combo_map.KENKO_TYOJU):
		video_kenko_tyoju.finished.connect(_on_video_finished)
		video_kenko_tyoju.play()
