extends Node

var score = 0
var ratio = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func add() -> void:
	score += Global.score * ratio

func combo() -> void:
	if ratio == 1:
		ratio = 1.25
	elif ratio == 1.25:
		ratio = 1.5
	elif ratio == 1.5:
		ratio = 2