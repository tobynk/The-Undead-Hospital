extends Node2D

@export var player: Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = player.global_position.x
	position.y = player.global_position.y
