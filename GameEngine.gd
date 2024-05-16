extends Node2D

@export var gamestart : bool = false

func _physics_process(delta):
	RenderingServer.set_default_clear_color(Color.BLACK)

func _ready():
	await LevelTransition.fade_from_black()
