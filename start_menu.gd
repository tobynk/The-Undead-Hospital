extends  Control
@onready var car_cash = $CarCash



func _on_play_pressed():
	car_cash.play()
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://test.tscn")

func _on_quit_pressed():
	get_tree().quit()
