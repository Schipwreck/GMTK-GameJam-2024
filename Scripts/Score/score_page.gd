extends Node

@onready var animation = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer2/Stars

func _ready():
	$TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/Score.text = "Score: %d" % Global.overallScore
	var starAnim = str(Global.stars) + "stars"
	animation.play(starAnim)

# callback function
func _process(_float) -> void:
	#$TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/Score.text = "Score: %d" % Global.overallScore
	pass

# continue button logic
func _on_continue_pressed():
	# empty string
	TransitionScene.transition()
	await TransitionScene.on_transition_finished
	var string = ""
	
	# increment level count by 1 every time continue is pressed
	Global.levelCount += 1
	
	# to add levels, increase value below
	if Global.levelCount == 4:
		
		Global.levelCount = 1
		# adding up overall scores
		var sum = 0
		for i in Global.arr.size():
			sum += Global.arr[i]
		Global.overallScore = sum
		string = "res://Scenes/End/endgame.tscn"
		get_tree().change_scene_to_file(string)
	else:
		string = "res://Scenes/Main/main_scene_" + str(Global.levelCount) + ".tscn"
		# change scene to next level
		get_tree().change_scene_to_file(string)
	# end if-else
	
# end function
