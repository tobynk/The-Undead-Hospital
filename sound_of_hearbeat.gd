extends Area2D
@onready var heart_moniter = $"Heart moniter"
var player = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(player)
	if player:
		heart_moniter.play()
	if not player:
		heart_moniter.stop()
		


func _on_area_entered(area):
	if area.is_in_group("player"):	
		player = true


func _on_area_exited(area):
	if area.is_in_group("player"):	
		player = false
