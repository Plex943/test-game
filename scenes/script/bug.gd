extends CharacterBody2D

var active :bool = false 
var player_nearby : bool = false
var can_attack: bool = true
var can_hit : bool = true
var heatlh :int = 20


func _process(_delta):
	var direction: Vector2 = (Globals.player_pos - position).normalized()
	var speed = 300
	if  active:
		look_at(Globals.player_pos)
		velocity = speed * direction
		move_and_slide()
	if player_nearby and can_attack:
		can_attack = false
		$AnimatedSprite2D.play("attack")
		speed = 500
		$timers/AttackCooldown.start()

func hit():
	$timers/HitCooldown.start()
	$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
	$Particles/HitParticles.emitting = true
	if can_hit:
		can_hit = false
		heatlh -= 10
		$AudioStreamPlayer2D.play()
	if heatlh <= 0:
		$Particles/HitParticles.emitting = true
		await get_tree().create_timer(0.5).timeout
		queue_free()

func _on_notice_area_body_entered(_body):
	active = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()

func _on_attack_area_body_entered(_body):
	player_nearby = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_body_exited(_body):
	player_nearby = false

func _on_attack_cooldown_timeout():
	can_attack = true

func _on_animated_sprite_2d_animation_finished():
	if player_nearby:
		Globals.health -= 10

func _on_hit_cooldown_timeout():
	can_hit = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
	
