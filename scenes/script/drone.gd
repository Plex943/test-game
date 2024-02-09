extends CharacterBody2D

var explosion_active: bool = false
var explosion_radius: int = 500
var active : bool = false
var max_speed: int = 600
var speed: int = 0
var speed_multiplier :int = 1
var vunerable: bool = true
var health: int = 30

func _ready():
	$droneSprite.show()
	$Explosion.hide()

func _process(delta):
	if active:
		var direction = (Globals.player_pos - position).normalized()
		look_at(Globals.player_pos)
		velocity = direction * speed * speed_multiplier
		var colision = move_and_collide(velocity * delta)
		if colision:
			explosion()
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()
			
func _on_drone_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 4)

func hit():
	$droneSprite.material.set_shader_parameter("progress", 1)
	if vunerable:
		health -= 10
		vunerable = false
		$Audios/AudioStreamPlayer2D.play()
	if health <= 0:
		explosion()
	$HitCooldowm.start()

func stop_movment():
	speed_multiplier = 0

func _on_drone_area_body_exited(body):
	active = false

func explosion():
	$AnimationPlayer.play("Explosion")
	explosion_active = true
	await $AnimationPlayer.animation_finished

func _on_hit_cooldowm_timeout():
	$droneSprite.material.set_shader_parameter("progress", 0)
	vunerable = true
