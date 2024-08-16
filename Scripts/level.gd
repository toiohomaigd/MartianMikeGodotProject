extends Node2D

@onready var start_position = $StartPosition

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# quit or reload level
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
		


func _on_deathzone_body_entered(body):
	# reset player position
	body.velocity = Vector2.ZERO
	body.global_position = start_position.global_position
