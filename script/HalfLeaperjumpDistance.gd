extends Line2D
onready var referance = get_parent().get_child(0)
onready var base = referance.position
export var x_offset:float = -5.0
func _ready():
	self.width = 0.5
	self.add_point(Vector2(base.x,base.y))
	self.add_point(Vector2(base.x+referance.distance/2,base.y))
#	self.add_point(Vector2(base.x,base.y+referance.height))
#	pass
func redraw():
	self.clear_points()
	referance = get_parent().get_child(0)
	base = referance.position
	self.width = 0.5
	self.add_point(Vector2(base.x,base.y))
	self.add_point(Vector2(base.x+referance.dir*referance.distance/2,base.y))



