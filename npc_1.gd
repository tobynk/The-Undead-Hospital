extends Area2D
@onready var interaction_area = $InteractionArea
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	label.show()
	if Input.is_action_pressed("interacted"):
		talk()
		print("save")


func _on_area_exited(area):
	label.hide()

func talk():
	print("hello i am________")
