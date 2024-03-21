extends KinematicBody2D

var time1
var time2

var currentVelocity = 0



export var height1:float	

export var peakTime1:float
export var peakTime2:float

export var phase2:float




var gravity1
var height2 
#
var gravity2
#
#
#
#
var verticalVelocity1
var verticalVelocity2
#
#var horizontaVelocity1
#var horizontaVelocity2

#var switchTime = peakTime2+phase2
#when velocity1 falls below switchVelocity switch to velocity2
var switchVelocity2

var jump = false

var falling = false
func loadVar():
	gravity1 = 2*(height1/pow((peakTime1),2))
	height2 = -(gravity1/2)*pow(((peakTime2+phase2)-peakTime1),2)+height1
	gravity2 = 2*(height2/pow((peakTime2),2))
	
	
	verticalVelocity1 = -(gravity1*peakTime1)
	verticalVelocity2 = -(gravity2*peakTime2)
	switchVelocity2 = gravity1*(peakTime2-peakTime1+phase2)
func update_display():
	pass

func _ready():
	loadVar()
#	switchVelocity2 = gravity1*(peakTime2-peakTime1+phase2)
	pass 
func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		jump = true


func set_height1(h):
	height1 = h
	loadVar()
#	print_debug(h)
	
	
func set_time1(t1):
	peakTime1 = t1
	loadVar()
#	print_debug(t1)
	

func set_time2(t2):
	peakTime2 = t2
	loadVar()
#	print_debug(t2)
	

func set_phase(p):
	phase2 = p
	print_debug(p)
	loadVar()
#	print_debug(p)
	

func _process(delta):
	if jump:
#		print_debug(height1)
#		print_debug(height2)
##		print_debug(phase2)
#		print_debug(gravity1)
#		print_debug(gravity2)
#		print_debug(switchVelocity2)
		if !falling:
			verticalVelocity1 = verticalVelocity1 + gravity1*delta
			
			currentVelocity =  verticalVelocity1
#			print_debug(currentVelocity)
		if currentVelocity > switchVelocity2:
			falling = true
			
#			verticalVelocity2 = currentVelocity + gravity2*delta
			currentVelocity +=  gravity2*delta
		if is_on_floor():
			falling = false
			verticalVelocity1 = -(gravity1*peakTime1)
			currentVelocity =  verticalVelocity1
	move_and_slide(Vector2(0,currentVelocity),Vector2.UP)
