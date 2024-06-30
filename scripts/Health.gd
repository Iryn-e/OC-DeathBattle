extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var local= clamp(get_parent().health / get_parent().maxhealth,0,100)
	get_child(0).get_child(0).size.x=local*200
	get_child(0).get_child(1).text=str(floor(local*100))
