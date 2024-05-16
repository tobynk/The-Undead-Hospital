extends CharacterBody2D

@export var player: Node2D
const speed = 250
var player_in_area = false
var kills_timer = false
@onready var muder = $Muder
var damage = 10
@onready var animated_sprite_2d = $AnimatedSprite2D
var health = 100
@onready var health_bar = $HealthBar

func _ready():
	health_bar.in_health(health)

func _physics_process(delta):
	print(health)
	if health >= -1.0:
		health_bar.health = health
	else:
		pass
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
	if health <= 0:
			queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("DeathBox"):
		health = health - (area.get_parent().DeathboxDamage)/10
	if area.is_in_group("player"):	
		player_in_area = true
 
func _on_area_2d_area_exited(area):
	player_in_area = false

func _on_muder_timeout():
	kills_timer = true
	
	
