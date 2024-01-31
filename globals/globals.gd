extends Node

signal health_update
signal laser_update
signal granade_update

var laser_amount = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		laser_update.emit()
var granade_amount = 5:
	get:
		return granade_amount
	set(value):
		granade_amount = value
		granade_update.emit()

var vunerable:bool = true
var health = 50:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if vunerable:
				health = value
				timer_hit_cooldown()
				vunerable = false
		health_update.emit()

func timer_hit_cooldown():
	await get_tree().create_timer(0.5).timeout
	vunerable = true

var player_pos: Vector2
