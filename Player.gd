extends CharacterBody2D
@export var speed = 400 
@onready var syringe = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Syringe"
@onready var scaple = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/scalpel"
@onready var bonesaw = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/bonesaw"
@onready var gun = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Gun"

@export var KillersTime = 1.0
@onready var HaveBoneSaw = false
@onready var HaveGun = false
@onready var HaveScalpel = false
@onready var HaveSyringe = false

@onready var item_1 = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Item1"
@onready var item_2 = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Item2"
@onready var item_3 = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Item3"
@onready var item_4 = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Item4"

@onready var hearts = $Camera2D/CanvasLayer/Hearts/Hearts
@onready var hearts_2 = $Camera2D/CanvasLayer/Hearts/Hearts2
@onready var hearts_3 = $Camera2D/CanvasLayer/Hearts/Hearts3

@onready var damage_label = $Camera2D/CanvasLayer/DamageLabel

@onready var hearts_level = $Camera2D/CanvasLayer/HeartsLevel

@onready var killing_timer = $"Killing Timer"

@onready var animated_sprite_2d = $AnimatedSprite2D

var Facing =0

var Hearts = 3
var HeartsHealth = 10

var ItemInHand = 1

var InRangeWithEnemy = false
var DamageFromEnemy= 0

var bullets = preload("res://Bullets.tscn")
@export var parent = Node2D

@onready var testbale_for_thing = $"CanvasLayer/Testbale for thing"

@onready var Shootingtimer = $ShootingTimer
var time_to_shoot = 0.5

func _ready():
	TurnInventoryItemOff()
	UpdateHearts()

func _process(delta):
	if InRangeWithEnemy == false:
		killing_timer.stop()
	RunDamage()
	handleShoot()
	Update_Item_in_hand()
	Input_for_item_in_hand()
	HandleTopDownMoveMent(delta)
	
		
func HandleTopDownMoveMent(poop):
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("move_up"):
			animated_sprite_2d.play("Waling_up")
		elif Input.is_action_pressed("move_down"):
			animated_sprite_2d.play("Waling_down")	
		else:
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("Walking_side")
			Facing = 1
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("move_down"):
			animated_sprite_2d.play("Waling_down")
		elif Input.is_action_pressed("move_up"):
			animated_sprite_2d.play("Waling_up")
		else:
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.play("Walking_side")
			Facing = 2
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("Waling_down")
		Facing = 3
	if Input.is_action_pressed("move_up"):
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("Waling_up")
		velocity.y -= 1
		Facing = 4
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if velocity.length() == 0:
		if Facing == 1:
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("Idle Side")
		if Facing == 2:
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.play("Idle Side")
		if Facing == 3:
			animated_sprite_2d.play("Idle Down")
		if Facing == 4:
			animated_sprite_2d.play("Idle Up")
	position += velocity * poop


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
	elif  Hearts == 0:
		queue_free()
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
	if area.is_in_group("Hearts"):
		if Hearts == 3:
			pass
		else: 
			Hearts += 1
			UpdateHearts()
		
		


func _on_area_2d_area_exited(area):
	if area.is_in_group("Enemy"):
		InRangeWithEnemy = false
	
func handleShoot():
	var target = get_global_mouse_position()
	if Input.is_action_pressed("Attack") && Shootingtimer.time_left <= 0.1 && ItemInHand == 4:
		Shootingtimer.stop()
		var bullet = bullets.instantiate()
		bullet.position = self.global_position
		bullet.target = target
		get_tree().root.add_child(bullet)
		Shootingtimer.start(time_to_shoot)
	
