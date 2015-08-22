
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"
var noise
var c = 1000000
var sprites
var sprites2


func _ready():

	sprites = get_node("Flower").get_children()
	sprites2 = get_node("Flower1").get_children()	
	set_process(true)
	
	
func _process(delta):
	for child in range(0,sprites.size()-1):
		sprites[child].rotate(rand_range(-2,2)*delta)
			
	for child in range(0,sprites2.size()-1):
		sprites2[child].rotate(rand_range(-2,2)*delta)

func digest():
	get_node("AnimationPlayer").play("digest")