extends Node2D

@export var sence_go_to = Node2D
@export var telporter = 0

#get_tree().change_scene_to_file("res://test.tscn")


func _on_area_2d_area_entered(area):
	print("collide with player")
	if telporter == 1:
		get_tree().change_scene_to_file("res://level_1.tscn")
		GameState.platformer = true
	if telporter == 2:
		get_tree().change_scene_to_file("res://level_1.tscn")
		GameState.platformer = true
