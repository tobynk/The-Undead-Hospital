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

@onready var item_1 = $CanvasLayer/Item1
@onready var item_2 = $CanvasLayer/Item2
@onready var item_3 = $CanvasLayer/Item3
@onready var item_4 = $CanvasLayer/Item4


@onready var ItemInHand = 1

func _ready():
	TurnInventoryItemOff()

func _process(delta):
	Update_Item_in_hand()
	Input_for_item_in_hand()
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

func Update_Item_in_hand():
	item_1.hide()
	item_2.hide()
	item_3.hide()
	item_4.hide()
	if ItemInHand == 1 && HaveSyringe:
		item_1.show()
	if ItemInHand == 2 && HaveScalpel:
		item_2.show()
	if ItemInHand == 3 && HaveBoneSaw:
		item_3.show()
	if ItemInHand == 4 && HaveGun:
		item_4.show()
		
func  Input_for_item_in_hand():
	if Input.is_action_pressed("Item_1"):
		ItemInHand = 1
	if Input.is_action_pressed("Item_2"):
		ItemInHand = 2	
	if Input.is_action_pressed("Item_3"):
		ItemInHand = 3
	if Input.is_action_pressed("Item_4"):
		ItemInHand = 4

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
	if area.is_in_group("Weapons"):  
		if area.Weapon == 1:
			HaveSyringe = true
		if area.Weapon == 2:
			HaveScalpel = true
		if area.Weapon == 3:
			HaveBoneSaw = true
		if area.Weapon == 4:
			HaveGun = true
		Update_Inventory_System_Item()
	if area.is_in_group("test"):
		print("test 1")  
