extends Node

# callback function
func _process(_delta):
	$Score.text = "Score: %d" % Global.overallScore

# continue button logic
func _on_continue_pressed():
	# empty string
	var string = ""
	
	# increment level count by 1 every time continue is pressed
	Global.levelCount += 1
	
	# to add levels, increase value below
	if Global.levelCount == 4:
		# reset level AND score once levelCount reaches the value above
		Global.levelCount = 1 # levelCount always needs to start at 1 due to Jacob's retarded naming conventions
		Global.overallScore = 0
		string = "res://Scenes/main_scene.tscn"
		# debug msg
		print(string)
		
		# change scene to first level, game restarting
		# can also make the game end here
		get_tree().change_scene_to_file(string)
	else:
		string = "res://Scenes/main_scene_" + str(Global.levelCount) + ".tscn"
		# debug msg
		print(string)
		
		# change scene to next level
		get_tree().change_scene_to_file(string)
		
		# debug msg
		print("Level changed")
	 
