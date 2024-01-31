extends StaticBody2D

signal player_entred_gate



func _on_area_2d_body_entered(_body):
	player_entred_gate.emit()
