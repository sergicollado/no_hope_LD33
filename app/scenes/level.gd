
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var oblivion
var door

func _ready():
	oblivion = get_node("DeathStar")
	oblivion.connect("body_enter",self,"flower_eat")
	door = get_node("Door")
	

func flower_eat(body):
	if(not body.has_method('degrade')):
		return 
	
	var door_binded = body.door_key
	get_node("Door/"+door_binded).open()
	body.degrade(oblivion.get_pos())
	oblivion.digest()
