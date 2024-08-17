extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# called every time pack items button is pressed
func _pack_items_pressed():
	# print("Hello World!")
	get_tree().change_scene_to_file("res://Scenes/#####.tscn")
	# call method in score script to calculate new score
	pass
