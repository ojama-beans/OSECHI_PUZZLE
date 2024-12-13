extends Timer

@onready var show_timer = $"ShowTimer"

func _ready() -> void:
	one_shot = true
	start(Global.timer)
	timeout.connect(_timeout)
	SignalManager.combo_occurred.connect(_on_combo_occurred)
	SignalManager.combo_ended.connect(_on_combo_ended)
	show_timer.text = str(int(Global.timer))

func _process(delta: float) -> void:
	show_timer.text = str(int(time_left))

func _timeout() -> void:
	SignalManager.time_over.emit()

func _on_combo_occurred(combo: int) -> void:
	if Global.check_any_combo_map(combo):
		paused = true

func _on_combo_ended() -> void:
	paused = false
