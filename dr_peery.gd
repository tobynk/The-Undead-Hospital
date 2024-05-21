extends CharacterBody2D

@export var player: Node2D
const speed = 300
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
@onready var saw_slicing = $"Saw Slicing"
@export var lighting = Node2D
var rng = RandomNumberGenerator.new()

func _ready():
	health_bar.in_health(health)
	animated_sprite_2d.play("Ideal")

func _physics_process(delta):
	Bossroommanger.boss_health = health

	if player == null:
			pass
	else:
		var X = player.global_position.x - global_position.x
		var Y = player.global_position.y - global_position.y
		var Disance_to_player = sqrt((X**2)+(Y**2))
		if Disance_to_player >= 120:
			player_in_area = false
		elif Disance_to_player <= 120:
			player_in_area = true
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
		saw_slicing.play()
		kills_timer = false
	if health <= 0:
		Bossroommanger.die_boss_died = self.position
		queue_free()
	if	GameState.talked_to_player:
		if lighting == null:
			pass
		else:
			var Lighting_in = rng.randf_range(10, 15.0)
			print(Lighting_in)
			await get_tree().create_timer(Lighting_in).timeout
			Bossroommanger.Lights = true

func _on_area_2d_area_entered(area):
	if area.is_in_group("DeathBox"):
		health = health - (area.get_parent().DeathboxDamage)/10

func _on_muder_timeout():
	kills_timer = true
	
	
