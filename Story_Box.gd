extends Area2D

@export var diaolgo_line = 0



func _on_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
