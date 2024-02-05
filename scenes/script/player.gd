extends CharacterBody2D

signal laser(pos, direction)
signal granade(pos, direction)

var can_laser: bool = true
var can_granade: bool = true

@export var max_speed : int = 500
var speed :int = max_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	look_at(get_global_mouse_position())
	velocity = direction * speed
	move_and_slide()
	
	Globals.player_pos = global_position
	
	# gerando e randomizando os disparos da arma
	
	
	var player_direction = (get_global_mouse_position() - global_position).normalized()
	if Input.is_action_pressed("primaryAction") and can_laser == true and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		var laser_markers = $laserMarkers.get_children()
		var lasers_location = laser_markers[randi() % laser_markers.size()]
		$timerLaser.start()
		can_laser = false
		$LaserParticles.emitting = true
		laser.emit(lasers_location.global_position, player_direction) 
		
	if Input.is_action_pressed("secondaryAction") and can_granade == true and Globals.granade_amount > 0:
		Globals.granade_amount -= 1
		$timerGranade.start()
		var pos = $laserMarkers.get_children()[0].global_position
		can_granade = false
		granade.emit(pos, player_direction)

 
func _on_timer_granade_timeout():
	can_granade = true


func _on_timer_laser_timeout():
	can_laser = true
	
func hit():
	Globals.health -= 10

func _on_gate_player_entred_gate():
	pass # Replace with function body.
	
	
