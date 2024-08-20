extends Node

# callback function
func _process(_delta):
	$Score.text = "Score: %d" % Global.overallScore
	pass

# continue button logic
func _on_continue_pressed():
	# empty string
	TransitionScene.transition()
	await TransitionScene.on_transition_finished
	var string = ""
	Global.stars = ""
	
	# increment level count by 1 every time continue is pressed
	Global.levelCount += 1
	
	# to add levels, increase value below
	if Global.levelCount == 4:
		
		# adding up overall scores
		var sum = 0
		for i in Global.arr.size():
			sum += Global.arr[i]
		Global.overallScore = sum
		
		# change scene to game end screen when level cap is hit
		Global.levelCount = 1
		string = "res://Scenes/End/endgame.tscn"
		get_tree().change_scene_to_file(string)
	else:
		string = "res://Scenes/Main/main_scene_" + str(Global.levelCount) + ".tscn"
		# change scene to next level
		get_tree().change_scene_to_file(string)
	# end if-else
	
# end function
