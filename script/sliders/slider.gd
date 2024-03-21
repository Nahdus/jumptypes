extends Control


var dragging = false

var label
var slider
var label_text

var height1
var gravity1
var peakTime1
var PeakTime2

export var player_nodepath:NodePath
var player_node

signal slide_value_changed

func _ready():
	label = $Label
	slider = $HSlider
	player_node = get_node(player_nodepath)
	slider.value = player_node.peakTime1
	label_text = label.text
	connect("slide_value_changed",get_parent(),"notify")
	connect("slide_value_changed",get_parent().get_node("phase"),"notify")
	
	label.set_text(label_text+" "+str(slider.value))
	#p depends on these
	
	



func _on_HSlider_value_changed(value):
	slider.value = value
	


func _on_HSlider_drag_ended(value_changed):
	label.set_text(label_text+" "+str(slider.value))
	emit_signal("slide_value_changed",self.name,slider.value)
	pass # Replace with function body.


func _on_HSlider_drag_started():
	pass # Replace with function body.
