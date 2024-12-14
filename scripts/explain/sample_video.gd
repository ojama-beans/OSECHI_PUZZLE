extends Node2D

@onready var video_stream_player_node = $VideoStreamPlayer
@onready var canvas_layer_node = $CanvasLayer

# ノードがシーンツリーに追加されたときに呼ばれる
func _ready() -> void:
    # シーンツリーから CanvasLayer ノードを取得
    if canvas_layer_node:
        canvas_layer_node.visible = true
    else:
        print("Error: CanvasLayer node not found")
    
    # 動画をループ再生する設定
    if video_stream_player_node:
        video_stream_player_node.loop = true
        video_stream_player_node.play()
    else:
        print("Error: VideoStreamPlayer node not found")
