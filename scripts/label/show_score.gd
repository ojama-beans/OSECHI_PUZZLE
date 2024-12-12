extends Label

func _ready() -> void:
	text = "0"

func _process(delta: float) -> void:
	if Score.score != 0:
		text = str(Score.score)
