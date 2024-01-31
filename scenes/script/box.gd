extends object

func hit():
	$Sprite2D2.hide()
	for c in range(0, 5):
		if not opened:
			var spawn_item_position = $item_markers.get_child(randi()%$item_markers.get_child_count()).global_position
			open.emit(spawn_item_position, current_direction)
	opened = true
