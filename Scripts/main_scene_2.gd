extends Node2D

# callback function
func _process(_delta):
	# display overall score
	$Score.text = "Score: %d" % Global.overallScore

func _on_packitup_button_pressed(_delta):
	# debug message
	print("Level " + str(Global.levelCount) + " passed!")
	
	# calc score goes here..
	Global.overallScore += 1
	
	# change scene
	get_tree().change_scene_to_file("res://Scenes/score_page.tscn")
