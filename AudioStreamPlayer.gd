extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func play_jump():
	var audio_stream : AudioStreamSample = preload("res://jump.wav")
	self.set_stream(audio_stream)
	self.set_volume_db(-10)
	self.play()

func play_land():
	var audio_stream : AudioStreamSample = preload("res://land.wav")
	self.set_stream(audio_stream)
	self.set_volume_db(-5)
	self.play()

func play_explosion():
	var audio_stream : AudioStreamSample = preload("res://explosion.wav")
	self.set_stream(audio_stream)
	self.set_volume_db(-12)
	self.play()
