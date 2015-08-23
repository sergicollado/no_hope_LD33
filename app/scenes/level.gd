
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var ui
var timer

func _ready():

	ui = get_node("CanvasLayer/UI")
	timer = Timer.new()
	add_child(timer)
	
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		door.connect('open_door',self,'_update_zones')
		
	

func _update_zones(zone_name):
	var zone = get_node("Door/"+zone_name)
	print(zone.get_child_count())
	if( zone.get_child_count() == 1):
		print('in zone')
		ui.set_center_text("NO HOPE IN "+zone_name)
		ui.show_center_label()
		timer.set_wait_time(1)
		timer.start()
		yield(timer,"timeout")
		get_node("NoHope/"+zone_name).show()



