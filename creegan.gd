extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	DialogueManager.show_example_dialogue_balloon(load("res://creegan.gd"),"Creegan")
