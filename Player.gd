extends Area2D
@export var speed = 400 
var NPCtalk = 0

func _process(delta):
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
	Interacted_with_NPC()
	

func Interacted_with_NPC():
	if NPCtalk == 1 and Input.is_action_just_pressed("Interacted"):
		print("it works") 


func _on_area_entered(area):
	NPCtalk = 1
	print("enter")


func _on_area_exited(area):
	NPCtalk = 0
	

