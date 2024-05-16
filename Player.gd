extends CharacterBody2D
@export var speed = 400 
@onready var syringe = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Syringe"
@onready var scaple = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/scalpel"
@onready var bonesaw = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/bonesaw"
@onready var gun = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Gun"


@onready var HaveBoneSaw = false
@onready var HaveGun = false
@onready var HaveScalpel = false
@onready var HaveSyringe = false

@onready var item_1 = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Item1"
@onready var item_2 = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Item2"
@onready var item_3 = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Item3"
@onready var item_4 = $"Camera2D/CanvasLayer/VBoxContainer/HBoxContainer/Item Bar/Item4"

@onready var damage_label = $Camera2D/CanvasLayer/DamageLabel



@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var death_box = $DeathBox/DeathBox

@onready var health_bar = $Camera2D/CanvasLayer/HealthBar

var Able_to_attack = false
var Facing =0

var ItemInHand = 0

var InRangeWithEnemy = false
var DamageFromEnemy= 0

var bullets = preload("res://Bullets.tscn")
var DeathboxDamage = 1
@export var parent = Node2D

@onready var Shootingtimer = $ShootingTimer
var time_to_shoot = 0.5
@export var damage = 10.0
@onready var swoosh = $swoosh


var Able_to_move = GameState.Able_to_move
var Story_dialogue_finish = 1

var is_platformer = GameState.platformer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_scale = 1.5
var jump_velocity = -1300

func _ready():
	TurnInventoryItemOff()
	spawn_in()
	health_bar.in_health(GameState.Health)



	

func _process(delta):
	#print(Health)
	if GameState.Health >= -1.0:
		health_bar.health =GameState.Health
	else:
		pass
	var is_platformer = GameState.platformer
	var Able_to_move = GameState.Able_to_move
	var HaveBoneSaw = GameState.HaveBoneSaw
	var HaveGun = GameState.HaveGun
	var HaveScalpel = GameState.HaveScalpel
	var HaveSyringe = GameState.HaveSyringe
	var ItemInHand = GameState.ItemInHand
	handleWeapons()
	Update_Item_in_hand()
	Input_for_item_in_hand()
	if Able_to_move == true && is_platformer == false:
		HandleTopDownMoveMent(delta)
	if Able_to_move == false:
		just_run_ideal()
	if Able_to_move == true && is_platformer == true:
		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		apply_gravity(delta)
		handle_jump()
		move_and_slide()
		update_animations(direction)
	
	
func spawn_in():
	Update_Item_in_hand()
	Update_Inventory_System_Item()
	
func apply_gravity(delta):
	velocity.y += gravity * gravity_scale * delta

func handle_jump():
	if Input.is_action_pressed("Jump") && is_on_floor():
		velocity.y = jump_velocity
		move_and_slide()
		
func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("Walking_side")
	else:
		animated_sprite_2d.play("Idle Side")
		
	if not is_on_floor():
		animated_sprite_2d.play("Jump")

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
	set_velocity(velocity)
	move_and_slide()
	
func just_run_ideal():
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
	


func TurnInventoryItemOff():
	bonesaw.hide()
	gun.hide()
	scaple.hide()
	syringe.hide()
	item_1.hide()
	item_2.hide()
	item_3.hide()
	item_4.hide()

func Update_Item_in_hand():
	item_1.hide()
	item_2.hide()
	item_3.hide()
	item_4.hide()
	if ItemInHand == 1 && GameState.HaveSyringe:
		item_1.show()
	if ItemInHand == 2 && GameState.HaveScalpel:
		item_2.show()
	if ItemInHand == 3 && GameState.HaveBoneSaw:
		item_3.show()
	if ItemInHand == 4 && GameState.HaveGun:
		item_4.show()
		
func  Input_for_item_in_hand():
	if Input.is_action_pressed("Item_1") && GameState.HaveSyringe:
		ItemInHand = 1
		DeathboxDamage = 5.0
	if Input.is_action_pressed("Item_2") && GameState.HaveScalpel:
		ItemInHand = 2
		DeathboxDamage = 10.0
	if Input.is_action_pressed("Item_3") && GameState.HaveBoneSaw:
		ItemInHand = 3
		DeathboxDamage = 15.0
	if Input.is_action_pressed("Item_4")&& GameState.HaveGun:
		ItemInHand = 4

func Update_Inventory_System_Item():
	if GameState.HaveBoneSaw:
		bonesaw.show()
	if  GameState.HaveGun:
		gun.show()
	if  GameState.HaveScalpel:
		scaple.show()
	if  GameState.HaveSyringe == true:
		syringe.show()
	else:
		return



		
func DealDamage(DamageDelt):
	if  GameState.Health >=0:
		GameState.Health -=DamageDelt
		print(GameState.Health)
	elif GameState.Health <=0:
		queue_free()
		get_tree().change_scene_to_file("res://die.tscn")
	else:
		return



func _on_area_2d_area_entered(area):
	if area.is_in_group("Weapons"):  
		if area.Weapon == 1:
			GameState.HaveSyringe = true
		if area.Weapon == 2:
			GameState.HaveScalpel = true
		if area.Weapon == 3:
			GameState.HaveBoneSaw = true
		if area.Weapon == 4:
			GameState.HaveGun = true
		Update_Inventory_System_Item()
	if area.is_in_group("Hearts"):
		if GameState.Health == 100:
			pass
		else: 
			GameState.Health += 25
	if area.is_in_group("story_line"):
		run_daiolge(area.diaolgo_line)

func _on_area_2d_area_exited(area):
	if area.is_in_group("Enemy"):
		InRangeWithEnemy = false
	
func handleWeapons():
	var target = get_global_mouse_position()
	if Input.is_action_pressed("Attack") && Able_to_attack && ItemInHand == 4:
		Shootingtimer.stop()
		var bullet = bullets.instantiate()
		bullet.position = self.global_position
		bullet.target = target
		get_tree().root.add_child(bullet)
		Shootingtimer.start(time_to_shoot)
	if Input.is_action_pressed("Attack") && Able_to_attack && ItemInHand == 1 && GameState.HaveSyringe:
		DeathboxDamage = 1
		death_box.disabled = false
		swoosh.show()
		swoosh.play("swoosh")
		await get_tree().create_timer(0.1).timeout
		death_box.disabled = true
		swoosh.hide()
		Able_to_attack = false
	if Input.is_action_pressed("Attack") && Able_to_attack && ItemInHand == 2 && GameState.HaveScalpel:
		DeathboxDamage = 10
		death_box.disabled = false
		swoosh.show()
		swoosh.play("swoosh")
		await get_tree().create_timer(0.1).timeout
		death_box.disabled = true
		swoosh.hide()
		Able_to_attack = false
	if Input.is_action_pressed("Attack") && Able_to_attack && ItemInHand == 3 && GameState.HaveBoneSaw:
		DeathboxDamage = 30
		death_box.disabled = false
		swoosh.show()
		swoosh.play("swoosh")
		await get_tree().create_timer(0.1).timeout
		death_box.disabled = true
		swoosh.hide()	
		Able_to_attack = false
	

func run_daiolge(number):
	if number == 1:
		DialogueManager.show_example_dialogue_balloon(load("res://Player.dialogue"),"Start")
	if number == 2:
		DialogueManager.show_example_dialogue_balloon(load("res://Player.dialogue"),"Walking_the_right_way")
	if number == 3:
		DialogueManager.show_example_dialogue_balloon(load("res://Player.dialogue"),"Level_1")
	if number == 4:
		DialogueManager.show_example_dialogue_balloon(load("res://mr.peery.dialogue"),"boss_battle")
		
		


func _on_shooting_timer_timeout():
	Able_to_attack = true

