extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func fade_from_black():
	animation_player.play("fade_in")
	await animation_player.animation_finished


