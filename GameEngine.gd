extends Node2D

@export var gamestart : bool = false

func _physics_process(delta):
	RenderingServer.set_default_clear_color(Color.BLACK)


