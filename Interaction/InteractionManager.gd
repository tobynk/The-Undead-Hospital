extends Node2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text ="[E] to"

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index !=-1:
		active_areas.remove_at(index)
		
		

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		
