
extends Node2D

export var speed = 50
var velocity
var friction = 0.95

func _ready():
	velocity = Vector2(0,0)
	set_fixed_process(true)
	

func _fixed_process(delta):
	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")
	var move_up = Input.is_action_pressed("ui_up")
	var move_down = Input.is_action_pressed("ui_down")
	var cancel = Input.is_action_pressed("ui_cancel")

	if(cancel):
		get_tree().quit()
	
	if(move_right):
		velocity.x += speed*delta

	if(move_left):
		velocity.x -= speed*delta

	if(move_up):
		velocity.y -= speed*delta

	if(move_down):
		velocity.y += speed*delta
		
	velocity.x *= friction
	velocity.y *= friction
	rotate(velocity.x*delta)
	rotate(velocity.y*delta)
	
	move(velocity)