extends AudioStreamPlayer


# 音の再生処理をここに書く
func play_sound(sound: AudioStream) -> void:
	self.stream = sound
	self.play()