extends Node2D

var lines = []
export var number = 50
var color
var interval = 0.5
var amount = 0

func _update_lines(delta):
	lines.resize(0)
	for line in range(number):
		var from = Vector2(rand_range(0,OS.get_video_mode_size().x),rand_range(0,OS.get_video_mode_size().y))
		var to = Vector2(from.x,rand_range(0,OS.get_video_mode_size().y))
		lines.insert(line,[from,to])

		
func _ready():
	color = Color(50)
	_update_lines(0)
	set_process(true)

func _process(delta):
	amount += delta
	if(amount > interval):
		color = Color(randi()%256)
		update()
		amount = 0

func _draw():
	for line in range(number):
		draw_line(lines[line][0],lines[line][1], color,randf())
		draw_line(lines[line][0],lines[line][1], color,randf())
	lines.resize(0)
	_update_lines(0)
