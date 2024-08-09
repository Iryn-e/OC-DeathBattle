extends Button

func on_Button_gui_input(event):
	if event is InputEventMouseButton and !event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().change_scene_to_packed(load("res://scenes/car1.tscn"))
func _ready():
	gui_input.connect(on_Button_gui_input)
