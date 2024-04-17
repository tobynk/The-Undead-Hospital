extends Node2D

@export var gamestart : bool = false
var jump_velocity: float = 500
var movement_speed: float = 200

var velocity = Vector2()
var speed = 200

func _process(delta):
	# Check for user input
	var input_vector = Vector2()
	
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1

	input_vector = input_vector.normalized()  # Normalize the input vector to ensure consistent speed

	velocity = input_vector * speed * delta  # Multiply by delta to ensure consistent movement across different frame rates
	
	# Apply velocity to the node's position
	position += velocity
