extends KinematicBody2D


var height = 80.0
var distance = 60
var time = 0.85
var dir = 1
onready var referance = get_parent().get_child(1)
var gravity = -(2*height)/pow((time/2),2)
var vertical_speed = gravity*(time/2)
var horizontal_speed = -(vertical_speed*(distance/2))/(4*height)
#var horizontal_speed = distance/(2*time)
var jump = false

var current_velocity = 0

func _ready():
	print_debug(horizontal_speed)
	pass

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		jump = true


func _process(delta):
	if jump:
		vertical_speed = vertical_speed-gravity*delta
		current_velocity = vertical_speed
		if self.is_on_floor():
			dir = - dir
	#		horizontal_speed=dir*horizontal_speed
			vertical_speed = gravity*(time/2)
			current_velocity = current_velocity 
			referance.redraw()
	move_and_slide(Vector2(0,current_velocity),Vector2.UP)
