extends Control


var dragging = false

var label
var slider
var label_text


#dependency
var height1
var gravity1
var peakTime1
var peakTime2

export var playerNode_path:NodePath
var playerNode

signal slide_value_changed

func _ready():
	label = $Label
	slider = $HSlider
	
	label_text = label.text
	
	
	playerNode = get_node(playerNode_path)
	
	#p depends on these
	height1 = playerNode.height1
	gravity1 = playerNode.gravity1
	peakTime1 = playerNode.peakTime1
	peakTime2 = playerNode.peakTime2
	print_debug(playerNode.peakTime1)
	print_debug(playerNode.peakTime2)
	print_debug(2*peakTime2 - peakTime1)
	slider.max_value = 2*peakTime2 - peakTime1
	slider.value = rand_range(0,slider.max_value)
	label.set_text(label_text+" "+str(slider.value))
	slider.step = slider.max_value/10
	print_debug(slider.max_value)
	connect("slide_value_changed",get_parent(),"notify")

func set_height1(value):
	height1 = value
	gravity1 = (2*height1/pow((peakTime1),2))
	slider.max_value = 2*peakTime2 - peakTime1
	print_debug(slider.max_value)
	
	
func set_time1(value):
	peakTime1 = value
	gravity1 = (2*height1/pow((peakTime1),2))
	slider.max_value = 2*peakTime2 - peakTime1
	slider.step = slider.max_value/10
	print_debug(peakTime2)
	print_debug(peakTime1)
	print_debug(slider.max_value)
	slider.value = rand_range(0,slider.max_value)
	label.set_text(label_text+" "+str(slider.value))
	emit_signal("slide_value_changed",self.name,slider.value)
	
func set_time2(value):
	peakTime2 = value
	gravity1 = (2*height1/pow((peakTime1),2))
	slider.max_value = 2*peakTime2 - peakTime1
	slider.step = slider.max_value/10
	print_debug(slider.max_value)
	slider.value = rand_range(0,slider.max_value)
	label.set_text(label_text+" "+str(slider.value))
	emit_signal("slide_value_changed",self.name,slider.value)
	
func _on_HSlider_value_changed(value):
	slider.value = value
	emit_signal("slide_value_changed",self.name,slider.value)


func _on_HSlider_drag_ended(value_changed):
	label.set_text(label_text+" "+str(slider.value))
	emit_signal("slide_value_changed",self.name,slider.value)
	pass # Replace with function body.


func _on_HSlider_drag_started():
	pass # Replace with function body.

func notify(variable,value):
	print_debug(variable)
	if variable in ["height1","time1","time2"]:
		.call("set_"+variable,value)
	
	
