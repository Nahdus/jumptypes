extends Control


var dragging = false

var label
var slider
var label_text

export var player_nodepath:NodePath
var player_node

signal slide_value_changed

func _ready():
	label = $Label
	slider = $HSlider
	player_node = get_node(player_nodepath)
	slider.value = player_node.peakTime2
	slider.max_value = get_parent().get_node("time1/HSlider").value
	slider.min_value = slider.max_value/2
	label_text = label.text
	
	connect("slide_value_changed",get_parent(),"notify")
	connect("slide_value_changed",get_parent().get_node("phase"),"notify")
	
	label.set_text(label_text+" "+str(slider.value))



func change_limits(_value):
	print_debug(slider.value)
	slider.max_value = _value
	slider.min_value = _value/2
#	slider.value = slider.min_value
#	label.set_text(label_text+" "+str(slider.value))
	label.set_text(label_text+" "+str(slider.value))
	emit_signal("slide_value_changed",self.name,slider.value)
	if slider.value<slider.min_value:
		slider.value = slider.min_value
		emit_signal("slide_value_changed",self.name,slider.value)
		label.set_text(label_text+" "+str(slider.value))
		return
	if slider.value>slider.max_value:
		slider.value = slider.max_value
		emit_signal("slide_value_changed",self.name,slider.value)
		label.set_text(label_text+" "+str(slider.value))
		return
	if slider.value>slider.min_value and slider.value<slider.max_value:
		emit_signal("slide_value_changed",self.name,slider.value)
		label.set_text(label_text+" "+str(slider.value))

func _on_HSlider_value_changed(value):
	slider.value = value
	


func _on_HSlider_drag_ended(value_changed):
	emit_signal("slide_value_changed",self.name,slider.value)
	label.set_text(label_text+" "+str(slider.value))
	pass # Replace with function body.


func _on_HSlider_drag_started():
	pass # Replace with function body.


func _on_time1_slide_value_changed(_nethod,value):
	print_debug(value)
	print_debug(slider.value)
	print_debug(slider.max_value)
	print_debug(slider.min_value)
	change_limits(value)
	emit_signal("slide_value_changed",self.name,slider.value)
	pass # Replace with function body.
