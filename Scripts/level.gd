extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# quit or reload level
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
		
