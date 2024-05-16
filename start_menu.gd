extends  Control


func _on_play_pressed():
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://test.tscn")

func _on_quit_pressed():
	get_tree().quit()
