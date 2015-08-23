
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var path = 'res://images/door_feel_'
var already_open = false

func _ready():
	var texture = load(_get_image(randi()%4))
	get_node("Sprite").set_texture(texture)
	
func open():
	if(already_open):
		return
		
	already_open = true
	var player = get_node("AnimationPlayer")
	player.play("open")
	yield(player,"finished")
	queue_free()
	
func _get_image(id):
	return path+str(id)+'.png'

