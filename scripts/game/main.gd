extends Node2D

@onready var osechi_scene = preload("res://scenes/osechi_1.tscn")

func _ready() -> void:
	var osechi = osechi_scene.instantiate()
	add_child(osechi)

func _process(delta: float) -> void:
	pass