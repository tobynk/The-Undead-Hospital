extends CharacterBody2D

var Damage = 5
const speed = 250  # Adjust the speed as needed
var health = 10
@export var player: Node2D
var DistanceToPlayer = 0
var gamestart = true
@onready var animated_sprite_2d = $AnimatedSprite2D
const PUSHBACK_FORCE = 20000

func _physics_process(delta):
	update_animation()
	gamestart = $"..".gamestart
	var X = player.gslobal_position.x - global_position.x
	var Y = player.global_position.y - global_position.y
	var Disance_to_player = sqrt((X**2)+(Y**2))
	if player && Disance_to_player <= 1000:
		var direction_to_player = (player.global_position - global_position).normalized()
		velocity = direction_to_player * speed 
		move_and_slide()
	else:
		pass
	if health <= 0:
		queue_free()

func take_damage(damage: int):
	health -=damage
	


func _on_area_2d_area_entered(area):
	print(area.name)
	if area.is_in_group("Bullet"):
		health = health - area.get_parent().damage
		area.get_parent().queue_free()
	if area.is_in_group("PlayerAttackBoxs"):
		print("this thing did dmag")
		health = health - area.get_parent().damage
	if area.is_in_group("DeathBox"):
		health = health - area.get_parent().DeathboxDamage
		var pushbackForce = (global_position - area.global_position).normalized() * PUSHBACK_FORCE
		velocity += pushbackForce 
		print(velocity)
		move_and_slide()
	
func update_animation():
	if velocity.x == 0:
		pass
	elif  velocity.x >= 5:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("Walking")
	elif  velocity.x <= 5:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("Walking")
