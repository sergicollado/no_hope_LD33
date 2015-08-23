
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
		if(zone_name == "zone_8"):
			show_final()
			return

		ui.set_center_text("NO HOPE IN "+zone_name)
		ui.show_center_label()
		timer.set_wait_time(1)
		timer.start()
		yield(timer,"timeout")
		get_node("NoHope/"+zone_name).show()
		

func show_final():
	var pos = get_node("Player/player/Camera2D").get_pos()
	var final_cam = get_node("Final/Camera")
	final_cam.set_pos(pos)
	final_cam.make_current()
	var player = get_node("Final/AnimationPlayer")
	player.play("zoom_out")
	get_node("Player").queue_free()

	yield(player,"finished")
	ui.set_center_text("NO LIFE")
	ui.show_center_label()

	timer.set_wait_time(2)
	timer.start()
	yield(timer,"timeout")
	ui.set_center_text("thanx for play the game \n \n  sergicollado@gmail.com")
	ui.show_label()
	
	print("final")


