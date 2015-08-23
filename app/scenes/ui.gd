
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass

func show_center_label():
	get_node("AnimationPlayer").play("show_central_label")

func set_center_text(text):
	get_node("Central_label").set_text(text)

func show_label():
	get_node("Central_label").set_opacity(1)