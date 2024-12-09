extends Node2D

# コンボ発生時のシグナル
signal combo_occurred(combo: int)

# osechiノードのシーンをロード
@onready var osechi_scene = preload("res://scenes/osechi_1.tscn")

# Timerノードをロード
@onready var timer_node = $Timer

# Comboノードをロード
@onready var combo_node = $"CanvasLayer/Combo"

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
	generate_osechi()
	timer_node.start(Global.timer)

func _process(delta: float) -> void:
	if _grid_changed:
		for osechi in _osechies:
			if can_place(Global.osechi_shape[osechi.find_child("Osechi_?").name]):
				_grid_changed = false
			else:
				# ゲームオーバー処理
				pass
	if _unplaced_osechi == 0:
		_osechies.clear()
		generate_osechi()
		_unplaced_osechi = Global.can_place_osechi
		_grid_changed = true

func _on_placed_osechi_1(placed: Vector2i, id: String) -> void:
	_unplaced_osechi -= 1
	_grid_changed = true
	_placed_osechi = placed
	_placed_id = id
	var combo = next_to_osechi()
	if combo:
		combo_occurred.emit(combo)
		pass
	Score.add()

func generate_osechi() -> void:
	for i in range(Global.can_place_osechi):
		var osechi = osechi_scene.instantiate()
		add_child(osechi)
		osechi.connect("placed_osechi_1", Callable(self, "_on_placed_osechi_1"))
		_osechies.append(osechi)

func can_place(osechi) -> bool:
	var grid_rows = Global.grid.size()
	var grid_cols = Global.grid[0].size()
	var osechi_rows = osechi.size()
	var osechi_cols = osechi[0].size()
	for i in range(grid_rows - osechi_rows + 1):
		for j in range(grid_cols - osechi_cols + 1):
			var can_place_here = true
			for x in range(osechi_rows):
				for y in range(osechi_cols):
					if Global.grid[i + x][j + y] != 0 and osechi[x][y] != 0:
						can_place_here = false
						break
				if not can_place_here:
					break
			if can_place_here:
				return true
	return false

func next_to_osechi() -> int:
	var combo = 0
	var pos_on_grid_modded = (_placed_osechi - Global.origin) / Global.osechi_size
	var shape = Global.osechi_shape[_placed_id]
	# osechiの角の座標
	var osechi = {
		"left_top": pos_on_grid_modded,
		"right_top": Vector2i(pos_on_grid_modded.x + shape[0].size(), pos_on_grid_modded.y),
		"left_bottom": Vector2i(pos_on_grid_modded.x, pos_on_grid_modded.y + shape.size()),
		"right_bottom": pos_on_grid_modded + Vector2i(shape[0].size(), shape.size())
	}
	# 判定範囲の座標
	var judge = {
		"left_top": Vector2i(osechi["left_top"].x - 1, osechi["left_top"].y - 1),
		"right_top": Vector2i(osechi["right_top"].x, osechi["right_top"].y - 1),
		"left_bottom": Vector2i(osechi["left_bottom"].x - 1, osechi["left_bottom"].y),
		"right_bottom": Vector2i(osechi["right_bottom"].x, osechi["right_bottom"].y)
	}
	# 判定範囲がgrid内にあるか
	var in_grid = {
		"left": judge["left_top"].x >= 0,
		"right": judge["right_top"].x < Global.grid[0].size(),
		"top": judge["left_top"].y >= 0,
		"bottom": judge["left_bottom"].y < Global.grid.size()
	}
	for x in range(shape[0].size()):
		# 上と下の判定
		combo |= (Global.grid[judge["left_top"].y][judge["left_top"].x + 1 + x] & shape[0][x] if in_grid["top"] else 0)
		combo |= (Global.grid[judge["right_bottom"].y][judge["left_top"].x + 1 + x] & shape[shape.size() - 1][x] if in_grid["bottom"] else 0)
	for y in range(shape.size()):
		# 左と右の判定
		combo |= (Global.grid[judge["left_top"].y + 1 + y][judge["left_top"].x] & shape[y][0] if in_grid["left"] else 0)
		combo |= (Global.grid[judge["left_top"].y + 1 + y][judge["right_bottom"].x] & shape[y][shape[0].size() - 1] if in_grid["right"] else 0)
	return combo
