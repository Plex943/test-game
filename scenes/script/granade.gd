extends RigidBody2D

@onready var anim = $Animation
var explosion_active:bool = false
var explosion_radius = 400

func explode():
	anim.play("explosion")
	explosion_active = true

func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("conteiner") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()
	
