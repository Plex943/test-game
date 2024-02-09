extends Node

signal health_update
signal laser_update
signal granade_update

var player_hit_audio : AudioStreamPlayer2D

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
var health = 100:
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
				player_hit_audio.play()
		health_update.emit()

func timer_hit_cooldown():
	await get_tree().create_timer(0.5).timeout
	vunerable = true

var player_pos: Vector2

func _ready():
	player_hit_audio = AudioStreamPlayer2D.new()
	player_hit_audio.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_audio)
