extends Area2D
@onready var label = $Label
@onready var PlayerInArea = false




# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerInArea && Input.is_action_just_pressed("interacted"):
		DialogueManager.show_example_dialogue_balloon(load("res://NPC_1.dialogue"),"Start")
		
	
	
		
	
	
func _on_area_entered(area):
	label.show()
	PlayerInArea = true
	
	


func _on_area_exited(area):
	label.hide()
	PlayerInArea = false


