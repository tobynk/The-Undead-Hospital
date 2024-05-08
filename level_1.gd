extends Node2D

@export var player = Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
