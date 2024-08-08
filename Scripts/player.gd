extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@export var gravity = 400
@export var speed = 125
@export var jump_force = 200

func _physics_process(delta):
	# player will drop down the Y axis every FPS
	velocity.y += gravity * delta
	
	# move player left and right
	var direction = Input.get_axis("Left", "Right")
	velocity.x = direction * speed
	
	# jump
	if Input.is_action_just_pressed("Jump"):
		velocity.y = -jump_force
		
	move_and_slide()
	
	




