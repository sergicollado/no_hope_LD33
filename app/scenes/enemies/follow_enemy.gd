
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"
export var speed = 5
var area
var target
var velocity
var status = 'no_target'
var target_body
var motion
var accel

func _ready():
	area = get_node("Area2D")
	area.connect("body_enter",self,"_follow")
	area.connect("body_exit",self,"_unfollow")
	accel = speed
	motion = Vector2(0,0)
	_update_random_target()
	velocity = Vector2(0,0)
	set_fixed_process(true)
	
func _follow(body):
	print(body.get_name())
	if(body.get_name() == "player"):
		status = "follow"
		target_body = body

func _unfollow(body):
	print("unfooolow")
	if(body.get_name() == "player"):
		status = "no_taget"
		_update_random_target()

func _fixed_process(delta):
		
	if((get_pos().distance_to(target) < 10) and status == 'no_target'):
		_update_random_target()
	
		
	if(status == 'follow'):
		target = target_body.get_pos()
		
	var direction = ( target - get_pos()).normalized()
	var desired = (direction * speed)
	
	print(get_pos().distance_to(target))
	motion += (desired - motion) * delta
	
	
	if((get_pos().distance_to(target) < 10) and status == 'follow'):
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
	get_node("AnimationPlayer").play("degrade")
	status = "dying"
	yield( get_node("AnimationPlayer"), "finished" )
	queue_free()