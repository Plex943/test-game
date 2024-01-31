extends LevelParent




func _on_exit_gate_body_entered(_body):
	var tween = create_tween()	
	tween.tween_property($player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
