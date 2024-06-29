extends CharacterBody2D


@export var SPEED = 300.0
@export var GRAVITY = 30
@export var JUMP_VELOCITY = 800.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"): # and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _input(event):
	if event is InputEventKey:
		if event.keycode==KEY_SHIFT:
			if event.is_pressed():
				get_child(0).texture=load("res://assets/characters/this.png")
			else:
				get_child(0).texture=load("res://assets/characters/sol.png")
