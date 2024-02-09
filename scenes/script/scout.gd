extends CharacterBody2D

var player_nearby : bool = false
var can_laser :bool = true
signal laser(pos, direction)
var right_gun : bool = true
var health: int = 30
var can_hit: bool = true

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		
		velocity.x = 100
		
		var markers = $spawnLaserPoisition.get_child(right_gun)
		var pos :Vector2 = markers.global_position
		right_gun = not right_gun
		var direction : Vector2 = (Globals.player_pos - position).normalized()
		if can_laser:
			laser.emit(pos, direction)
			$laserCooldown.start()
		can_laser = false

func hit():
	$hitCooldowm.start()
	$Sprite2D.material.set_shader_parameter("progress", 1)
	if can_hit:
		health -= 10
		can_hit = false
		$AudioStreamPlayer2D.play()
	if health <= 0:
		queue_free()

func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true


func _on_hit_cooldowm_timeout():
	can_hit = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
