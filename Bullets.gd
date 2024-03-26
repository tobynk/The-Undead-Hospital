extends CharacterBody2D

var speed = 100.0
var got_mouse = false
var target

func _physics_process(delta):
	
	var direction_to_target = (target - global_position).normalized()
	velocity = direction_to_target * speed 
	move_and_slide()
		
	
		
