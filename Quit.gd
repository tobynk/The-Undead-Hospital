extends  Control

@onready var main_menu = $"../Main Menu"
@onready var quit = $"."

func _physics_process(delta):
	RenderingServer.set_default_clear_color(Color.GRAY)


func _on_start_menu_pressed():
	get_tree().change_scene_to_file("res://test.tscn")


func _on_leave_pressed():
	get_tree().quit()
