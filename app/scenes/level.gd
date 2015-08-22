
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var oblivion

func _ready():
	oblivion = get_node("DeathStar")
	oblivion.connect("body_enter",self,"flower_eat")
	
	

func flower_eat(body):
	if(not body.has_method('degrade')):
		return 
	
	body.degrade(oblivion.get_pos())
	oblivion.digest()
