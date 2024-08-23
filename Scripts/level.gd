extends Node2D

@onready var start_position = $StartPosition

@onready var player = $Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# quit or reload level
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
		


func _on_deathzone_body_entered(body):
	# reset player position
	reset_player()


func _on_trap_touched_player():
	reset_player()
	
func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start_position.global_position
