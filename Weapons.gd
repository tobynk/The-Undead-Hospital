extends Node2D

@export var Weapon = 1
@onready var syringe = $Node2D/Syringe
@onready var scaple = $Node2D/scaple
@onready var bonesaw = $Node2D/bonesaw
@onready var gun = $Node2D/Gun

signal WeaponPickedUp(WeaponNumber)

# Called when the node enters the scene tree for the first time.
func _ready():
	ReaderSprite()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ReaderSprite():
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
	emit_signal("WeaponPickedUp",Weapon)
