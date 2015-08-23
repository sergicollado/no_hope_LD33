
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"
var noise
var c = 1000000
var sprites
var sprites2
var sampler

func _ready():
	sprites = get_node("Flower").get_children()
	sprites2 = get_node("Flower1").get_children()
	sampler = get_node("SamplePlayer")
	connect("body_enter",self,"flower_eat")
	get_node("VisibilityNotifier2D").connect("enter_screen",self,"_on_enter")
	get_node("VisibilityNotifier2D").connect("exit_screen",self,"_on_exit")

func _process(delta):
	for child in range(0,sprites.size()-1):
		sprites[child].rotate(rand_range(-2,2)*delta)
			
	for child in range(0,sprites2.size()-1):
		sprites2[child].rotate(rand_range(-2,2)*delta)

func digest():
	get_node("AnimationPlayer").play("digest")
	
func flower_eat(body):
	if(not body.has_method('degrade')):
		return 
	
	sampler.play("sound_door")
	var door_binded = body.get_door_binded()
	get_tree().get_root().get_node("Node2D/Door/"+door_binded).open()
	body.degrade(get_pos())
	digest()
	
func _on_enter():
	set_fixed_process(true)
func _on_exit():
	set_fixed_process(false)