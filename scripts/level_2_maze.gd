extends Node2D

@export var boss = Node2D
@export var key = preload("res://key.tscn")
@onready var l_ighting = $LIghting

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if typeof(GameState.Health) == TYPE_INT: 
		if Bossroommanger.boss_health  <= 0:
			var key = key.instantiate()
			get_tree().root.add_child(key)
			key.position = Bossroommanger.die_boss_died
	if Bossroommanger.Lights:
		l_ighting.show()
		await get_tree().create_timer(1.0).timeout
		l_ighting.hide()
		Bossroommanger.Lights = false
		
		
