extends CharacterBody2D


const SPEED = 300.0
var clicks = 0

func _ready():
	var clicks = get_viewport().get_mouse_position()

func _physics_process(delta):
	print(clicks)
