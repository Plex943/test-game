extends CharacterBody2D

var active : bool = false
var speed = 200
var player_near: bool = false
var health : int = 100
var vunerable : bool = true

func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_pos

func _physics_process(_delta):
	if active:
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + PI / 2


func _on_notice_area_body_entered(_body):
	active  = true
	$AnimationPlayer.play("walk")


func _on_notice_area_body_exited(_body):
	active = false


func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_pos

func _on_hit_timer_timeout():
	vunerable = true

func _on_attcak_area_body_entered(body):
	player_near = true
	$AnimationPlayer.play("attack")

func _on_attcak_area_body_exited(body):
	player_near = false

func attack():
	if player_near:
		Globals.health -= 20

func hit():
	if vunerable:
		health -= 10
		vunerable = false
		$timers/HitTimer.start()
	if  health < 0:
		queue_free()
