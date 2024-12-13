extends Label

const SAVE_FILE_PATH = "user://max_score.save"

var _max_score = 0

func _ready() -> void:
	text = "0"
	load_max_score()

func _process(delta: float) -> void:
	update_max_score(Score.score)
	text = str(_max_score)

func update_max_score(current_score: int) -> void:
	if current_score > _max_score:
		_max_score = current_score
		save_max_score()

func save_max_score() -> void:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(_max_score)
		file.close()

func load_max_score() -> void:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			_max_score = file.get_var()
			file.close()
	else:
		_max_score = 0
