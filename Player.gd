extends Area2D
@export var speed = 400 
@onready var bonesaw = $CanvasLayer/bonesaw
@onready var gun = $CanvasLayer/Gun
@onready var scalpel = $CanvasLayer/scaple
@onready var syringe = $CanvasLayer/Syringe

@onready var HaveBoneSaw = false
@onready var HaveGun = false
@onready var HaveScalpel = false
@onready var HaveSyringe = false

func _ready():
	TurnInventoryItemOff()

func _process(delta):
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta

func TurnInventoryItemOff():
	bonesaw.hide()
	gun.hide()
	scalpel.hide()
	syringe.hide()

func Update_Inventory_System_Item():
	if HaveBoneSaw:
		bonesaw.show()
	if  HaveGun:
		gun.show()
	if  HaveScalpel:
		scalpel.show()
	if  HaveSyringe == true:
		syringe.show()
	else:
		return

func _on_area_entered(area):
	if area.Weapon == 1:
		HaveSyringe = true
	if area.Weapon == 2:
		HaveScalpel = true
	if area.Weapon == 3:
		HaveBoneSaw = true
	if area.Weapon == 4:
		HaveGun = true
	Update_Inventory_System_Item()
