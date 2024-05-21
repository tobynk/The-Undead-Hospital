extends CharacterBody2D

var Damage = 5
const speed = 250  # Adjust the speed as needed
var health = 30
@export var player: Node2D
var DistanceToPlayer = 0
var gamestart = true
@onready var animated_sprite_2d = $AnimatedSprite2D
const PUSHBACK_FORCE = 20000
@onready var timer = $Timer
var kills_timer = true
var player_in_area = false
@onready var bite = $bite


func _physics_process(delta):
	if kills_timer && player_in_area:
		player_in_area
		player.DealDamage(Damage)
		kills_timer = false
		bite.play()
	if player == null:
		pass
	else:
		update_animation()
		var X = player.global_position.x - global_position.x
		var Y = player.global_position.y - global_position.y
		var Disance_to_player = sqrt((X**2)+(Y**2))
		if player && Disance_to_player <= 1000:
			var move_to_player = (player.global_position - global_position).normalized()
			velocity = move_to_player * speed 
			move_and_slide()
		else:
			pass
		if health <= 0:
			queue_free()

func take_damage(damage: int):
	health -=damage
	


func _on_area_2d_area_entered(area):
	if area.is_in_group("Bullet"):
		health = health - area.get_parent().damage
		area.get_parent().queue_free()
	if area.is_in_group("PlayerAttackBoxs"):
		health = health - area.get_parent().damage
	if area.is_in_group("DeathBox"):
		health = health - area.get_parent().DeathboxDamage
		var pushbackForce = (global_position - area.global_position).normalized() * PUSHBACK_FORCE
		velocity += pushbackForce 
		print(velocity)
		move_and_slide()
	if area.is_in_group("player"):	
		player_in_area = true
	
func update_animation():
	if velocity.x == 0:
		pass
	elif  velocity.x >= 1:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("Walking")
	elif  velocity.x <= 1:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("Walking")


func _on_timer_timeout():
	kills_timer = true
	
	
 


func _on_area_2d_area_exited(area):
	if area.is_in_group("player"):	
		player_in_area = false
