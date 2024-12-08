extends Node2D

# osechiノードのシーンをロード
@onready var osechi_scene = preload("res://scenes/osechi_1.tscn")

# 動的生成されたosechiノードの参照リスト
var _osechies: Array = []

# 未配置のパズルの数
var _unplaced_puzzle = Global.can_place_puzzle

# 盤面の状態が変わったフラグ
var _grid_changed = false

func _ready() -> void:
	place_puzzle()

func _process(delta: float) -> void:
	if _grid_changed:
		for osechi in _osechies:
			if can_place(Global.osechi_shape[osechi.find_child("Osechi_?").name]):
				_grid_changed = false
			else:
				# ゲームオーバー処理
				pass
	if _unplaced_puzzle == 0:
		_osechies.clear()
		place_puzzle()
		_unplaced_puzzle = Global.can_place_puzzle
		_grid_changed = true

func _on_placed_osechi_1() -> void:
	_unplaced_puzzle -= 1
	_grid_changed = true

func place_puzzle() -> void:
	for i in range(Global.can_place_puzzle):
		var osechi = osechi_scene.instantiate()
		add_child(osechi)
		osechi.connect("placed_osechi_1", Callable(self, "_on_placed_osechi_1"))
		_osechies.append(osechi)

func can_place(puzzle) -> bool:
	var grid_rows = Global.grid.size()
	var grid_cols = Global.grid[0].size()
	var puzzle_rows = puzzle.size()
	var puzzle_cols = puzzle[0].size()
	for i in range(grid_rows - puzzle_rows + 1):
		for j in range(grid_cols - puzzle_cols + 1):
			var can_place_here = true
			for x in range(puzzle_rows):
				for y in range(puzzle_cols):
					if Global.grid[i + x][j + y] == 1 and puzzle[x][y] == 1:
						can_place_here = false
						break
				if not can_place_here:
					break
			if can_place_here:
				return true
	return false
