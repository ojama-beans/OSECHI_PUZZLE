extends Timer

@onready var show_timer = $"ShowTimer"

func _ready() -> void:
	one_shot = true
	timeout.connect(_timeout)
	show_timer.text = "60"

func _process(delta: float) -> void:
	show_timer.text = str(time_left)

func _timeout() -> void:
	SignalManager.time_over.emit()
