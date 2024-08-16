extends CharacterBody2D

class_name Player

@onready var animated_sprite = $AnimatedSprite2D
@export var gravity = 400
@export var speed = 125
@export var jump_force = 200

func _physics_process(delta):
	# player will drop down the Y axis every FPS
	velocity.y += gravity * delta
	
	# move player left and right
	var direction = Input.get_axis("Left", "Right")
	if direction !=0:
		animated_sprite.flip_h = (direction == -1)
		
	velocity.x = direction * speed
	
	# jump
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		jump(jump_force)
			
	
	move_and_slide()
	update_animations(direction)
	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
			
func jump(force):
	velocity.y = -force
	
	




