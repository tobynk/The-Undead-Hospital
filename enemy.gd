extends CharacterBody2D

var Damage = 5
const speed = 250  # Adjust the speed as needed
var health = 10
@export var player: Node2D
var DistanceToPlayer = 0
var gamestart = true
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	update_animation()
	gamestart = $"..".gamestart
	var X = player.global_position.x - global_position.x
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


func _on_area_2d_area_entered(area):
	if area.is_in_group("Bullet"):
		health = health - area.get_parent().damage
		area.get_parent().queue_free()
		
func update_animation():
	if velocity.x == 0:
		pass
	elif  velocity.x >= 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("Walking")
		print("moving right")
	elif  velocity.x <= 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("Walking")
		print("moving Left")
