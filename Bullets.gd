extends CharacterBody2D

var speed = 1000.0
var got_mouse = false
var target
var direction_to_target = Vector2.ZERO
@export var damage = 10.0

func _ready():
	direction_to_target = (target - global_position).normalized()
	
func _physics_process(delta):
	velocity = direction_to_target * speed 
	move_and_slide()
		
	
		


func _on_suicide_timer_timeout():
	queue_free()
