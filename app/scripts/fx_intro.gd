extends Node2D

var interval = 0.1
var interval_amount = 0
var triangles = []


func _generate():
	triangles.resize(0)
	var triangles_length = int(rand_range(3,20))
	
	for triangle in range(triangles_length) :
		var rand_size = rand_range(0,10)
		var triangle_conf = {}
		var pos_first_point = rand_range(0,100)
		var pos_second_point = rand_range(0,100)
		var pos_third_point = rand_range(0,100)
		triangle_conf["points"] = [Vector2(0-rand_size + pos_first_point,0 +pos_third_point ),Vector2(50+rand_size +pos_first_point ,0 +pos_second_point ),Vector2(25+ pos_third_point ,25+rand_size*5 +pos_first_point)]
		var newColor  = Color(int(rand_range(200,255)))
		triangle_conf["colors"] = [ newColor,newColor,newColor]
		triangles.insert(triangle,triangle_conf)
		
func _ready():
	set_process(true)
	
func _process(delta):
	interval_amount += delta
	if (interval_amount > interval) :
		update()
		interval_amount = 0
		
func _draw():
	_generate()
	for triangle in range(triangles.size()-1):
		draw_polygon(triangles[triangle]["points"],triangles[triangle]["colors"]) 

