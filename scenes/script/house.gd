extends Area2D

signal player_entred
signal player_exit

func _on_body_entered(body):
	if body.name == "player":
		player_entred.emit()

func _on_body_exited(body):
	if body.name == "player":
		player_exit.emit()
