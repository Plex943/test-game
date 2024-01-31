extends CharacterBody2D

var active : bool = false
var speed: int = 400
var vunerable: bool = true
var health: int = 30

func _ready():
	$droneSprite.show()
	$Explosion.visible = false

func _process(_delta):
	if active:
		var direction = (Globals.player_pos - position).normalized()
		look_at(Globals.player_pos)
		velocity = direction * speed
		move_and_slide()

func _on_drone_area_body_entered(_body):
	active = true

func hit():
	$droneSprite.material.set_shader_parameter("progress", 1)
	if vunerable:
		health -= 10
		vunerable = false
	if health <= 0:
		explosion()
	$HitCooldowm.start()

func _on_drone_area_body_exited(body):
	active = false

func explosion():
	$AnimationPlayer.play("Explosion")
	await $AnimationPlayer.animation_finished
	queue_free()


func _on_hit_cooldowm_timeout():
	$droneSprite.material.set_shader_parameter("progress", 0)
	vunerable = true
