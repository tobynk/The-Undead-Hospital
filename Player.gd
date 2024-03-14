extends Area2D
@export var speed = 400 
@onready var bonesaw = $CanvasLayer/ColorRect/bonesaw
@onready var gun = $CanvasLayer/ColorRect/gun
@onready var scalpel = $CanvasLayer/ColorRect/Scalpel
@onready var syringe = $CanvasLayer/ColorRect/Syringe

@onready var HaveBoneSaw = false
@onready var HaveGun = false
@onready var HaveScalpel = false
@onready var HaveSyringe = false

@onready var ItemNode = get_node("res://Weapons.gd")

func _ready():
	TurnInventoryItemOff()

func _process(delta):
	ItemNode.connect("WeaponPickedUp",self, Test())
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

func Test():
	pass


