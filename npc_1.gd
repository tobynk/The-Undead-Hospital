extends Area2D
@onready var label = $Label
var interactionarea = false

# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if interactionarea and Input.is_action_just_pressed("interacted"):
		print("e is pressed")
	
func _on_area_entered(area):
	label.show()
	interactionarea = true


func _on_area_exited(area):
	label.hide()
	interactionarea = false

