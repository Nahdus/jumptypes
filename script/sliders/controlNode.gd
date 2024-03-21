extends Control

export var player_path:NodePath
var player_node
func _ready():
	player_node = get_node(player_path)
	


func notify(slider_name,slider_value):
	player_node.call("set_"+slider_name,slider_value)
