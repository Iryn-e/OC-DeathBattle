extends CharacterBody2D

@export var maxhealth:float=100;# make some logic to set the max health to the character's health. for now use 100
@export var health:float=maxhealth;

@export var SPEED = 300.0
@export var GRAVITY = 30
@export var JUMP_VELOCITY = 800.0

func bool_to_int(booly):
	return 1 if booly else 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept"): # and is_on_floor():
	if (Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_SPACE)
	 or Input.is_key_pressed(KEY_W)) and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = bool_to_int(
		Input.is_key_pressed(KEY_RIGHT)
		or Input.is_key_pressed(KEY_D)
		) - bool_to_int(
		Input.is_key_pressed(KEY_LEFT)
		or Input.is_key_pressed(KEY_A)
	)
	Input.get_axis("ui_left", "ui_right")
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

