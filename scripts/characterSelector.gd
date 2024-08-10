extends Sprite2D

func pressed_correctly(event):
	if event is InputEventMouseButton and !event.pressed:
		return  event.button_index == MOUSE_BUTTON_LEFT;
	else: return false

#func char_binary(event):
	#if pressed_correctly(event):
		#print(event)
		#get_tree().change_scene_to_packed(load("res://scenes/car1.tscn"))
	#pass
#func char_sol(event):
	#if pressed_correctly(event):
		#print(event)
		#get_tree().change_scene_to_packed(load("res://scenes/World.tscn"))
	#pass
func select_to_scene(button_nodename,scene_url):
	var this = func (event):
		if pressed_correctly(event):
			get_tree().change_scene_to_packed(load(scene_url))
	get_node(button_nodename).gui_input.connect(this)

# Called when the node enters the scene tree for the first time.
func _ready():
	select_to_scene('platFormButton',"res://scenes/car1.tscn")
	select_to_scene('SolButton',"res://scenes/World.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
