extends Node2D

@export var player: Node2D

func _ready():
	position.x = player.global_position.x
	position.y = player.global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = player.global_position.x+15
	position.y = player.global_position.y+15
