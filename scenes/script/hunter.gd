extends CharacterBody2D

var active : bool = false
var speed = 200

func _ready():
	$NavigationAgent2D.target_position = Globals.player_pos

func _physics_process(delta):
	if active:
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		look_at(Globals.player_pos)


func _on_notice_area_body_entered(body):
	active  = true


func _on_notice_area_body_exited(body):
	active = true


func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_pos
