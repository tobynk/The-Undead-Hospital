extends Node2D

@export var Weapon = 1
@onready var syringe = $Syringe
@onready var scaple = $Scapel
@onready var bonesaw = $bonesaw
@onready var gun = $Gun

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
	if area.is_in_group("player"):
		queue_free()
