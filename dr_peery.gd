extends CharacterBody2D

@export var player: Node2D
const speed = 250
var player_in_area = false
var kills_timer = false
@onready var muder = $Muder
var damage = 10


func _physics_process(delta):
	if GameState.talked_to_player:
		if player == null:
			pass
		else:
			var X = player.global_position.x - global_position.x
			var Y = player.global_position.y - global_position.y
			var Disance_to_player = sqrt((X**2)+(Y**2))
			if player:
				var move_to_player = (player.global_position - global_position).normalized()
				velocity = move_to_player * speed 
				move_and_slide()
			else:
				pass
	if player_in_area && kills_timer:
		player.DealDamage(damage)
		kills_timer = false

func _on_area_2d_area_entered(area):
	player_in_area = true
 
func _on_area_2d_area_exited(area):
	player_in_area = false

func _on_muder_timeout():
	kills_timer = true
	
	
