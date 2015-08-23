extends Node2D

var start_allowed=false
var already_start = false

func _ready():
	set_process(true)

func _process(delta):
	var start = Input.is_action_pressed("ui_accept")

	if(start):
		if(already_start or not start_allowed):
			return
		already_start = true
		get_node("AnimationPlayer").play("gameOn")
		yield(get_node("AnimationPlayer"),"finished")
		get_tree().change_scene("res://scenes/level.scn")
		
func allowed():
	start_allowed = true