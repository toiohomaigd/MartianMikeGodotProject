extends Node2D

@export var next_level: PackedScene = null

@onready var start = $Start
@onready var exit = $Exit
@onready var hud = $UILayer/HUD

var player = null
@export var level_time = 5
var timer_node = null
var time_left

var win = false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	if player != null:
		player.global_position = start.get_spawn_pos()
	
	var traps = get_tree().get_nodes_in_group("traps")
	var on_trap_touched = Callable(self, "_on_trap_touched_player")
	
	for trap in traps:
		trap.connect("touched_player", on_trap_touched)
		
	exit.body_entered.connect(_on_exit_body_entered)
	
	time_left = level_time
	hud.set_time_label(time_left)
	
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	
func _on_level_timer_timeout():
	if win == false:
		time_left -= 1
		hud.set_time_label(time_left)
		if time_left < 0:
			reset_player()
			time_left = level_time

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
	player.global_position = start.get_spawn_pos()
		
func _on_exit_body_entered(body):
	if body is Player:
		if next_level != null:
			exit.animate()
			player.active = false
			win = true
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_packed(next_level)
