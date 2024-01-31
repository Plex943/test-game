extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/peojectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/peojectiles/granade.tscn")
var item_scene: PackedScene = preload("res://scenes/user interface/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for conteiner in get_tree().get_nodes_in_group("conteiner"):
		conteiner.connect("open", spawn_items)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", create_laser)

func spawn_items(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$items.call_deferred("add_child", item)

func _on_player_laser(pos, direction):
	create_laser(pos, direction)

func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$projectiles.add_child(laser)
	

func _on_player_granade(pos, direction):
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = direction * 300
	$projectiles.add_child(granade)





