extends CharacterBody2D
@export var speed = 400 
@onready var syringe = $"CanvasLayer/Item Bar/Syringe"
@onready var scaple = $"CanvasLayer/Item Bar/scalpel"
@onready var bonesaw = $"CanvasLayer/Item Bar/bonesaw"
@onready var gun = $"CanvasLayer/Item Bar/Gun"

@export var KillersTime = 1.0
@onready var HaveBoneSaw = false
@onready var HaveGun = false
@onready var HaveScalpel = false
@onready var HaveSyringe = false

@onready var item_1 = $"CanvasLayer/Item Bar/Item1"
@onready var item_2 = $"CanvasLayer/Item Bar/Item2"
@onready var item_3 = $"CanvasLayer/Item Bar/Item3"
@onready var item_4 = $"CanvasLayer/Item Bar/Item4"

@onready var hearts = $CanvasLayer/Hearts/Hearts
@onready var hearts_2 = $CanvasLayer/Hearts/Hearts2
@onready var hearts_3 = $CanvasLayer/Hearts/Hearts3

@onready var damage_label = $CanvasLayer/DamageLabel

@onready var hearts_level = $CanvasLayer/HeartsLevel

@onready var killing_timer = $"Killing Timer"

var Hearts = 3
var HeartsHealth = 10

var ItemInHand = 1

var InRangeWithEnemy = false
var DamageFromEnemy= 0

var bullets = preload("res://Bullets.tscn")
@export var parent = Node2D

@onready var testbale_for_thing = $"CanvasLayer/Testbale for thing"


func _ready():
	TurnInventoryItemOff()
	UpdateHearts()

func _process(delta):
	testbale_for_thing.text=(str(killing_timer.time_left))
	if InRangeWithEnemy == false:
		killing_timer.stop()
	RunDamage()
	handleShoot()
	hearts_level.text = (str(HeartsHealth))
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
	scaple.hide()
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
		scaple.show()
	if  HaveSyringe == true:
		syringe.show()
	else:
		return


func RunDamage():
	if InRangeWithEnemy:
		if killing_timer.time_left <  0.01:
			DealDamage(DamageFromEnemy)
			killing_timer.start(KillersTime)
		
func LossHeart():
	if HeartsHealth < 1:
		Hearts -=1 
		UpdateHearts()
		HeartsHealth = 10
	else:
		UpdateHearts()
		return

func DealDamage(DamageDelt):
	damage_label.text = (str(DamageDelt))
	damage_label.show()
	if  HeartsHealth >=0:
		HeartsHealth -=DamageDelt
		LossHeart()
	else:
		return
	LossHeart()

func  UpdateHearts():
	if Hearts ==0:
		hearts.hide()
		hearts_2.hide()
		hearts_3.hide()
	elif Hearts == 1:
		hearts.show()
		hearts_2.hide()
		hearts_3.hide()
	elif  Hearts == 2:
		hearts.show()
		hearts_2.show()
		hearts_3.hide()
	elif  Hearts == 3:
		hearts.show()
		hearts_2.show()
		hearts_3.show()
		


func _on_area_2d_area_entered(area):
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
	if area.is_in_group("Enemy"):
		InRangeWithEnemy = true  
		DamageFromEnemy = area.get_parent().Damage
		killing_timer.start()
		DealDamage(area.get_parent().Damage)


func _on_area_2d_area_exited(area):
	if area.is_in_group("Enemy"):
		InRangeWithEnemy = false
	
func handleShoot():
	var target = get_global_mouse_position()
	if Input.is_action_pressed("Attack"):
		var bullet = bullets.instantiate()
		bullet.position = self.global_position
		get_tree().root.add_child(bullet)
		bullet.target = target
	

