extends Node2D

@export var sence_go_to = Node2D
@export var telporter = 0

#get_tree().change_scene_to_file("res://test.tscn")


func _on_area_2d_area_entered(area):
	if telporter == 1:
		await LevelTransition.fade_to_black()
		get_tree().change_scene_to_file("res://level_1.tscn")
		LevelTransition.fade_from_black()
		GameState.platformer = true
	if telporter == 2:
		get_tree().change_scene_to_file("res://level_2_maze.tscn")
		GameState.platformer = false
