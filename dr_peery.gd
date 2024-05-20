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
var able_to_attack = false
var key = preload("res://key.tscn")
@export var sence = Node2D
func _ready():
	health_bar.in_health(health)
	animated_sprite_2d.play("Ideal")

func _physics_process(delta):
	if health >= -1.0:
		health_bar.health = health
	else:
		pass
	if GameState.talked_to_player:
		if able_to_attack:
			pass
		if not able_to_attack:
			animated_sprite_2d.play("Start_Walking")
			await get_tree().create_timer(1).timeout
			able_to_attack = true
	if able_to_attack:
		if player == null:
			pass
		else:
			var X = player.global_position.x - global_position.x
			var Y = player.global_position.y - global_position.y
			var Disance_to_player = sqrt((X**2)+(Y**2))
			if player:
				var move_to_player = (player.global_position - global_position).normalized()
				velocity = move_to_player * speed 
				animated_sprite_2d.play("Walking")
				move_and_slide()
			else:
				pass
	if player_in_area && kills_timer:
		player.DealDamage(damage)
		kills_timer = false
	if health <= 0:
			var key = key.instantiate()
			sence.root.add_child(key)
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
	
	
