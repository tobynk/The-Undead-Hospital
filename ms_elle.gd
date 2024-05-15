extends Area2D
@onready var label = $Label
@onready var PlayerInArea = false
@onready var animated_sprite_2d = $AnimatedSprite2D





# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()
	animated_sprite_2d.play("Cry")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerInArea && Input.is_action_just_pressed("Interacted"):
		DialogueManager.show_example_dialogue_balloon(load("res://Ms_elle.dialogue"),"talk_1")
		animated_sprite_2d.play("Standing but crying")
	
	
		
	
	
func _on_area_entered(area):
	label.show()
	PlayerInArea = true
	
	


func _on_area_exited(area):
	label.hide()
	PlayerInArea = false
