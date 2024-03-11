extends Area2D
@onready var label = $Label




# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()
	DialogueManager.show_example_dialogue_balloon(load("res://NPC_1.dialogue"),"start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
		
	
	
func _on_area_entered(area):
	label.show()


func _on_area_exited(area):
	label.hide()


