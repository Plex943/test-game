extends StaticBody2D
class_name object

@onready var current_direction: Vector2 = Vector2.UP.rotated(rotation)
signal open(pos, direction)
var opened: bool = false
