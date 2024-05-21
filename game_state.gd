extends Node
var Able_to_move = true
var platformer = false
var player = "res://player.tscn"
var room = 1
var story = 0
@onready var HaveBoneSaw = false
@onready var HaveGun = false
@onready var HaveScalpel = false
@onready var HaveSyringe = false
var Health = 100
var ItemInHand = 1
var talked_to_player = false


func chage():
	get_tree().change_scene_to_file("res://die.tscn")
