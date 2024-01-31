extends object

func hit():
	$Sprite2D2.hide()
	for toilet in range(0, 1):
		if not opened:
			var spawn_items = $markersItems/Marker2D.global_position
			open.emit(spawn_items, current_direction)
	opened = true
