extends Node2D

@export var sence_go_to = Node2D

#get_tree().change_scene_to_file("res://test.tscn")


func _on_area_2d_area_entered(area):
	get_tree().change_scene_to_file("res://level_1.tscn")
	GameState.platformer = true
