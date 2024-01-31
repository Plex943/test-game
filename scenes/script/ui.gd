extends CanvasLayer

var green_color = Color("2fde00")
var red_color = Color("ff0000")

@onready var laser_label :Label= $laserCounter/Label
@onready var granade_label :Label= $granadeCounter/Label
@onready var laser_icon :TextureRect= $laserCounter/TextureRect
@onready var granade_icon :TextureRect= $granadeCounter/TextureRect
@onready var health_bar :TextureProgressBar= $healthBar/progress_bar


func _ready():
	Globals.connect("health_update", health_count)
	Globals.connect("laser_update", laser_count)
	Globals.connect("granade_update", granade_count)
	laser_count()
	granade_count()
	health_count()
	
func laser_count():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func granade_count():
	granade_label.text = str(Globals.granade_amount)
	update_color(Globals.granade_amount, granade_label, granade_icon)
	
func update_color(amount, label, icon):
	if amount <= 0:
		label.modulate = red_color
		icon.modulate = red_color
		
	else:
		label.modulate = green_color
		icon.modulate = green_color
		
func health_count():
	health_bar.value = Globals.health


