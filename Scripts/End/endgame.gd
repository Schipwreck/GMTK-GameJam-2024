extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# previous level scores
	$previous_level_1.text = "Level %d Score:" % (Global.levelCount) + " %d" % (Global.arr[Global.levelCount - 1])
	$previous_level_2.text = "Level %d Score:" % (Global.levelCount + 1) + " %d" % (Global.arr[Global.levelCount])
	$previous_level_3.text = "Level %d Score:" % (Global.levelCount + 2) + " %d" % (Global.arr[Global.levelCount + 1])
	$Score.text = "Overall Score: %d" % Global.overallScore
	
	# clear the array once this scene is entered, in preparation for next game
	Global.arr.clear()
	Global.overallScore = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
