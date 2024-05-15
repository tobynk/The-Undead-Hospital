extends Node2D

@export var gamestart : bool = false

func _physics_process(delta):
	RenderingServer.set_default_clear_color(Color.BLACK)

func _ready():
	get_tree().paused =true
	await LevelTransition.fade_from_black()
	get_tree().paused =false
