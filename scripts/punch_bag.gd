extends CharacterBody2D

@export var maxhealth:float=100;# make some logic to set the max health to the character's health. for now use 100
@export var health:float=maxhealth;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
func _process(delta):
	if health<=0:
		queue_free()
