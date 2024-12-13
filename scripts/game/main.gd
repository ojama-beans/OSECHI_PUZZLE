extends Node2D

# osechiノードのシーンをロード
@onready var osechi_scenes = []

# concavepolygonのひな型
const GeneratedOsechi = preload("res://scripts/data_structure/generated_osechi.gd")

# 動的生成されたosechiノードの参照リスト
var _osechies = []

# 未配置のosechiの数
var _unplaced_osechi = Global.can_place_osechi

# 盤面の状態が変わったフラグ
var _grid_changed = false

# 置かれたosechiの座標
var _placed_osechi = Vector2i.ZERO

# 置かれたosechiのID
var _placed_id = ""

func _ready() -> void:
	reset_global_value()
	for i in range(Global.osechi_num):
		var path = "res://scenes/osechi_" + str(i + 1) + ".tscn"
		osechi_scenes.append(load(path))
	generate_osechi()
	SignalManager.on_game_complete.connect(_on_game_complete)

func _process(delta: float) -> void:
	if _grid_changed:
		for osechi in _osechies:
			if not osechi["on_grid"]:
				break;
			var name = osechi["node"].find_child("Osechi_?").name
			if can_place(Global.osechi_shape[name]):
				_grid_changed = false
			else:
				SignalManager.cannot_place_osechi.emit()
	if _unplaced_osechi == 0:
		generate_osechi()
		_unplaced_osechi = Global.can_place_osechi
		_grid_changed = true

func _on_placed_osechi(placed: Vector2i, id: Node) -> void:
	_unplaced_osechi -= 1
	_grid_changed = true
	_placed_osechi = placed
	_placed_id = id
	_osechies.filter(func(osechi): return osechi["node"] == id)[0]["on_grid"] = true
	var combo = next_to_osechi()
	if combo:
		SignalManager.combo_occurred.emit(combo)
	Score.add()

func _on_game_complete() -> void:
	get_tree().change_scene_to_file("res://scenes/end.tscn")

func reset_global_value() -> void:
	Global.reset()
	Score.reset()

func generate_osechi() -> void:
	for i in range(Global.can_place_osechi):
		var osechi_id = get_random_int(Global.osechi_num - 1)
		var osechi = osechi_scenes[osechi_id].instantiate()
		add_child(osechi)
		osechi.placed_osechi.connect(_on_placed_osechi)
		var osechi_status = {
			"node": osechi,
			"on_grid": false
		}
		_osechies.append(osechi_status)

func get_random_int(n: int) -> int:
	return randi() % (n + 1)

func can_place(osechi) -> bool:
	var grid_rows = Global.grid.size()
	var grid_cols = Global.grid[0].size()
	var osechi_rows = osechi.size()
	var osechi_cols = osechi[0].size()
	for i in range(grid_cols - osechi_cols + 1):
		for j in range(grid_rows - osechi_rows + 1):
			var can_place_here = true
			for x in range(osechi_cols):
				for y in range(osechi_rows):
					if Global.grid[j + y][i + x] != 0 and osechi[y][x] != 0:
						can_place_here = false
						break
				if not can_place_here:
					break
			if can_place_here:
				return true
	return false

func next_to_osechi() -> int:
	var combo = 0
	var placed_osechi = _osechies.filter(func(osechi): return osechi["node"] == _placed_id)[0]["node"]
	var placed_name = placed_osechi.find_child("Osechi_?").name
	var placed_type = int(placed_name.split("_")[1])
	var placed_osechies = placed_osechi.find_children("Collision_Osechi_?*")
	var placed_shapes = []
	var placed_transforms = []
	for osechi_node in placed_osechies:
		placed_shapes.append(osechi_node.shape)
	for osechi_node in placed_osechies:
		placed_transforms.append(osechi_node.global_transform)

	for osechi_status in _osechies:
		var osechi = osechi_status["node"]
		if osechi == placed_osechi:
			continue
		var osechies = osechi.find_children("Collision_Osechi_?*")
		var osechi_shapes = []
		var osechi_transforms = []
		for osechi_node in osechies:
			osechi_shapes.append(osechi_node.shape)
		for osechi_node in osechies:
			osechi_transforms.append(osechi_node.global_transform)
		var collision = false
		for i in range(placed_shapes.size()):
			for j in range(osechi_shapes.size()):
				if placed_shapes[i].collide(placed_transforms[i], osechi_shapes[j], osechi_transforms[j]):
					collision = true
		if collision:
			var name = osechi.find_child("Osechi_?").name
			var osechi_type = int(name.split("_")[1])
			combo |= 2**(osechi_type - 1)
	if combo:
		combo |= 2**(placed_type - 1)
	print(combo)
	return combo
