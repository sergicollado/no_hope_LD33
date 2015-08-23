
extends KinematicBody2D

export var speed = 50
var area
var target
var velocity
var status = 'no_target'
var target_offset

var target_body
var motion


func _ready():
	area = get_node("Area2D")
	area.connect("body_enter",self,"_follow")
	area.connect("body_exit",self,"_unfollow")
	target_offset = Vector2(100,-150)
	
	get_node("VisibilityNotifier2D").connect("enter_screen",self,"_on_enter")
	motion = Vector2(0,0)
	_update_random_target()
	velocity = Vector2(0,0)

func _on_enter():
	set_fixed_process(true)

func _follow(body):
	if(body.get_name() == "player" and status != 'dying'):
		status = "follow"
		target_body = body

func _unfollow(body):
	if(body.get_name() == "player" and status != 'dying'):
		status = "no_taget"
		_update_random_target()

func _fixed_process(delta):
		
	if((get_pos().distance_to(target) < 10) and status == 'no_target'):
		_update_random_target()
	
		
	if(status == 'follow'):
		target = (target_body.get_pos() - target_offset)
		
	var direction = ( target - get_pos()).normalized()
	var desired = (direction * speed)

	motion += (desired - motion) * delta
	
	
	if((get_pos().distance_to(target) < 5) and status == 'follow'):
		move_to(target)
	else:	
		move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide( motion ) 
		velocity = n.slide( velocity )
		move( motion )
		if(status == 'no_target'):
			_update_random_target()


func _update_random_target():
	target = Vector2(rand_range(0,1000),rand_range(0,1000))
	

func _on_visibility_enter_screen():
	print("enter visibility")
	set_fixed_process(true)

func degrade(position):
	target = position
	status = "dying"
	get_node("AnimationPlayer").play("degrade")
	get_node("Particles2D").set_emitting(true)
	yield( get_node("AnimationPlayer"), "finished" )
	queue_free()
	
func get_door_binded():
	return get_parent().get_name()+'/'+get_name()