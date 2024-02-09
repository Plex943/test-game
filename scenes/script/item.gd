extends Area2D

var rotate_speed : int = 5
var all_items = ["laser", "laser", "laser", "granade", "health"]
var type_item = all_items[randi()%len(all_items)]

var direction:Vector2
var distance :int = randi_range(150, 250)


func _ready():
	if type_item == "laser":
		$Sprite2D.modulate = Color("00afd8")
	if type_item == "granade":
		$Sprite2D.modulate = Color("f22740")
	if type_item == "health":
		$Sprite2D.modulate = Color("4ed356")
	
	var target_position = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_position, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))
	
func _process(delta):
	rotation += rotate_speed * delta



func _on_body_entered(_body):
	if type_item == "laser":
		Globals.laser_amount += 5
	if type_item == "granade":
		Globals.granade_amount += 2
	if type_item == "health":
		Globals.health += 15
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
	
