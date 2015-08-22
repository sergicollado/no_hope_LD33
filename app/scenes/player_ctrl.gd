
extends Node2D

var light
var player

func _ready():
	light = get_node("Light2D")
	player = get_node("player")
	set_process(true)
	
func _process(delta):
	light.set_pos(player.get_pos())
	
	


