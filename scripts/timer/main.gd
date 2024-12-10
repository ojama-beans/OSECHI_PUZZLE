extends Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	one_shot = true
	timeout.connect(_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _timeout() -> void:
	SignalManager.time_over.emit()
