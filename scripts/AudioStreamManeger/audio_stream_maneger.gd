extends Node

# 効果音とBGMのためのAudioStreamPlayerをそれぞれ保持
var sfx_player: AudioStreamPlayer
var bgm_player: AudioStreamPlayer

func _ready() -> void:
    # AudioStreamPlayerを作成
    sfx_player = AudioStreamPlayer.new()
    bgm_player = AudioStreamPlayer.new()

    # BGMの音量を設定 (-10dBに設定)
    bgm_player.volume_db = -10

    # ノードをシーンに追加
    add_child(sfx_player)
    add_child(bgm_player)

# 効果音の再生関数
func play_sound(sound: AudioStream) -> void:
    sfx_player.stream = sound
    sfx_player.play()  # 効果音を再生

# BGMの再生関数
func play_bgm(sound: AudioStream) -> void:
    if not bgm_player.is_playing():  # BGMが再生中でない場合のみ再生
        sound.loop = true  # ループ再生
        bgm_player.stream = sound
        bgm_player.play()  # BGMを再生

# BGMを停止する関数
func stop_bgm() -> void:
    if bgm_player.is_playing():
        var target_volume = -80
        var step = 1
        var delay = 0.1  # 0.1秒ごとに音量を下げる
        while bgm_player.volume_db > target_volume:
            bgm_player.volume_db -= step
            await get_tree().create_timer(delay).timeout
        bgm_player.stop()  # BGMを停止
