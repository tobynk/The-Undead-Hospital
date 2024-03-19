extends Node2D

@export var Weapon = 1
@onready var syringe = $Node2D/Syringe
@onready var scaple = $Node2D/scaple
@onready var bonesaw = $Node2D/bonesaw
@onready var gun = $Node2D/Gun

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderSprite()

func RenderSprite():
	if Weapon == 1:
		syringe.show()
	elif Weapon == 2:
		scaple.show()
	elif Weapon == 3:
		bonesaw.show()
	elif Weapon == 4:
		gun.show()
	else:
		return





func _on_area_entered(area):
	queue_free()
