extends PathFollow2D

var active: bool = false

@onready var gun1 = $turret/Sprite2D2
@onready var gun2 = $turret/Sprite2D3

func _ready():
	pass

func _process(delta):
	progress_ratio += 0.02 * delta
	if active:
		$turret.look_at(Globals.player_pos)

func _on_range_body_entered(body):
	$AnimationPlayer.play("laser_charge")
	active = true


func _on_range_body_exited(body):
	active = false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel(true) 
	tween.tween_property($turret/RayCast2D/Line2D, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property($turret/RayCast2D2/Line2D, "width", 0, randf_range(0.1, 0.5))
	await tween.finished
	$AnimationPlayer.stop()


func fire():
	Globals.health -= 20
	gun1.modulate.a = 1
	gun2.modulate.a = 1
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun1, "modulate:a", 0, randf_range(0.1, 0.5))
	tween.tween_property(gun2, "modulate:a", 0, randf_range(0.1, 0.5))
