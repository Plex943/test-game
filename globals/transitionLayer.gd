extends CanvasLayer

func  change_scene(scene):
	$Animation.play("black_fade")
	await $Animation.animation_finished
	get_tree().change_scene_to_file(scene)
	$Animation.play_backwards("black_fade")
