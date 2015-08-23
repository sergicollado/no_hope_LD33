extends StaticBody2D


var path = 'res://images/door_feel_'
var already_open = false

func _ready():
	add_to_group("doors")
	var texture = load(_get_image(randi()%4))
	add_user_signal("open_door")
	get_node("Sprite").set_texture(texture)
	
func open():
	if(already_open):
		return
		
	already_open = true
	var player = get_node("AnimationPlayer")
	get_node("Particles2D 2").set_emitting(true)
	get_node("Particles2D").set_emitting(true)
	player.play("open")
	yield(player,"finished")
	emit_signal("open_door",get_parent().get_name())
	queue_free()
	
func _get_image(id):
	return path+str(id)+'.png'

