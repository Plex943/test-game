extends LevelParent

func _on_gate_player_entred_gate():
	var tween = create_tween()
	tween.tween_property($player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")

func _on_house_player_entred():
	var camera_tween = get_tree().create_tween()
	camera_tween.tween_property($player/Camera2D, "zoom", Vector2(1,1), 1)

func _on_house_player_exit():
	var camera_tween = get_tree().create_tween()
	camera_tween.tween_property($player/Camera2D, "zoom", Vector2(0.6,0.6), 1)
