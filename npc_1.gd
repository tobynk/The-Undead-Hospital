extends Area2D
@onready var label = $Label
@onready var dialogtext = $Dialogtext
@onready var NPCtalklabel = get_node("Dialogtext/NPCtalkLabel")
@onready var NPCnamelabel = get_node("Dialogtext/Name")
var interactionarea = false
var interactiontalks = 1 
var totalinteractiontalk = 2
var player = preload("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()
	dialogtext.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if interactionarea and Input.is_action_just_pressed("interacted"):
		print("e is pressed")
		dialogtext.show()
		NPCtalklabel.text = str("NPC 1 IS TALKING part 1")
		NPCnamelabel.text = str("NPC 1")
		player.stop_movements()
	if Input.is_action_just_pressed("Next_talk"):
		if interactiontalks == 1:
			NPCtalklabel.text = str("NPC 1 IS TALKING part 2")
			print("one")
			interactiontalks += 1
		elif  interactiontalks == 2:
			NPCtalklabel.text = str("NPC 1 IS TALKING part 3")
			print("two")
			interactiontalks += 1
		else:
			dialogtext.hide()
			player.start_movements()
		
			
	
func _on_area_entered(area):
	label.show()
	interactionarea = true


func _on_area_exited(area):
	label.hide()
	interactionarea = false

