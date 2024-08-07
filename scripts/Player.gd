extends CharacterBody2D

@export var maxhealth:float=100;# make some logic to set the max health to the character's health. for now use 100
@export var health:float=maxhealth;
@onready var animation = $AnimationPlayer
@onready var player_sprite = $Sprite2D

@export var SPEED = 300.0
@export var GRAVITY = 30
@export var JUMP_VELOCITY = 800.0

var animation_to_play=""
var debounce=false
var face_direction=0

func bool_to_int(booly):
	return 1 if booly else 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY

	# Handle jump
	if (Input.is_key_pressed(KEY_UP) 
	   or Input.is_key_pressed(KEY_SPACE)
	   or Input.is_key_pressed(KEY_W)) and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = bool_to_int(Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D)) - bool_to_int(Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A))
	
	if (direction):
		face_direction=direction
		get_child(4).position.x = 121 * direction
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
	if position.y > 10000:
		# kill the player here once that is implemented
		position.y=237
		position.x=60
	move_and_slide()
	updateAnimation(velocity)

func get_index_of(array,index):
	if array.size()==0:
		return null
	if array.size()>index:
		return array[index]
	else:
		return null

func FindFirstChild(name_,array=null,node_list=null):
	if array and array.size()==0:
		return null
	var index = 0
	while (true):
		var node
		if array==null:
			if node_list:
				node=get_child(index)
			else:
				node=node_list.get_child(index)
		else:
			node=get_index_of(array,index)
		if node == null:
			return null;
		elif node.name==name_:
			return node
		index+=1

func gparent_tree(of):
	var parent=of
	var out=''
	while parent:
		out = '\'' + parent.name + '\'.' + out
		parent=parent.get_parent()
	return out

func init_regex(pattren):
	var r=RegEx.new()
	r.compile(pattren)
	return r

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func on_shift_press():
	var overlap=get_child(4).get_overlapping_bodies()
	var First_child = get_index_of(overlap,0)
	#FindFirstChild('PunchBag',get_child(4).get_overlapping_bodies())
	if First_child!= null and ('health' in First_child)and ('maxhealth' in First_child):
		First_child.health-=5

	debounce = true
	animation_to_play = "sol_punch_1"
	await wait(0.8)
	animation_to_play = "sol_idle"
	debounce = false

func updateAnimation(velocity):
	# If going left, flip sprite (Assumes sprites always are right)
	if velocity.x < 0: player_sprite.flip_h = true
	elif velocity.x > 0: player_sprite.flip_h = false
	animation.play(animation_to_play)

func _input(event):
	if event is InputEventKey:
		if event.keycode==KEY_SHIFT:
			if event.is_pressed():
				on_shift_press()

func _ready():
	animation_to_play = "sol_idle"
	pass
