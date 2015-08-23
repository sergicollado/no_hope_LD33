
extends KinematicBody2D

export var speed = 5
export var door_key = ''
var area
var target
var velocity
var status = STATUS_NO_TARGET
var STATUS_NO_TARGET = 'no_target'
var STATUS_FOLLOW = 'follow'
var STATUS_DYING = 'dying'
 
var target_body
var motion


func _ready():
	area = get_node("Area2D")
	area.connect("body_enter",self,"_follow")
	area.connect("body_exit",self,"_unfollow")
	get_node("VisibilityNotifier2D").connect("enter_screen",self,"_on_enter")
	
	motion = Vector2(0,0)
	_update_random_target()
	velocity = Vector2(0,0)

func _on_enter():
	set_fixed_process(true)

func _follow(body):
	print(body.get_name())
	if(body.get_name() == "player"):
		status = STATUS_FOLLOW
		target_body = body

func _unfollow(body):
	print("unfooolow")
	if(body.get_name() == "player"):
		status = STATUS_NO_TARGET
		_update_random_target()

func _fixed_process(delta):
		
	if((get_pos().distance_to(target) < 10) and status == STATUS_NO_TARGET):
		_update_random_target()
	
		
	if(status == STATUS_FOLLOW):
		target = target_body.get_pos()
		
	var direction = ( target - get_pos()).normalized()
	var desired = (direction * speed)
	
	motion += (desired - motion) * delta
	
	
	if((get_pos().distance_to(target) < 10) and status == STATUS_FOLLOW):
		move_to(target)
	else:	
		move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide( motion ) 
		velocity = n.slide( velocity )
		move( motion )
		if(status == STATUS_NO_TARGET):
			_update_random_target()


func _update_random_target():
	target = Vector2(rand_range(0,1000),rand_range(0,1000))

func _on_visibility_enter_screen():
	print("enter visibility")
	set_fixed_process(true)

func degrade(position):
	target = position
	get_node("AnimationPlayer").play("degrade")
	get_node("Particles2D").set_emitting(true)
	status = STATUS_DYING
	yield( get_node("AnimationPlayer"), "finished" )
	queue_free()