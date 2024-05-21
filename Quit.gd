extends  Control

@onready var main_menu = $"../Main Menu"
@onready var quit = $"."

func _physics_process(delta):
	RenderingServer.set_default_clear_color(Color.GRAY)

func _on_leave_pressed():
	get_tree().quit()
