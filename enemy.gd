extends CharacterBody2D

var Damage = 5
const speed = 250  # Adjust the speed as needed
@export var player: Node2D
var DistanceToPlayer = 0
var gamestart = true


func _physics_process(delta):
	gamestart = $"..".gamestart
	var X = player.global_position.x - global_position.x
	var Y = player.global_position.y - global_position.y
	var Disance_to_player = sqrt((X**2)+(Y**2))
	if player && Disance_to_player <= 1000:
		var direction_to_player = (player.global_position - global_position).normalized()
		velocity = direction_to_player * speed 
		move_and_slide()
	else:
		print("notworking")
		pass
