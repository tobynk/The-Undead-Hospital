extends Area2D
@export var speed = 400 
var NPCtalk = 0
@export var IsAbleToMove = true

func _process(delta):
	if IsAbleToMove:
		var velocity = Vector2.ZERO 
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta

func stop_movements():
	IsAbleToMove = false
	
func start_movements():
	IsAbleToMove = true
	



