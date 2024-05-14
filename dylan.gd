extends Area2D

var talked = false
func _on_area_entered(area):
	if talked == false:
		talked = true
		DialogueManager.show_example_dialogue_balloon(load("res://Dylan.dialogue"),"dylan_likes_to_talk")
