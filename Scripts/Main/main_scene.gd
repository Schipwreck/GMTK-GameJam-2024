extends Node2D

func _ready():
	Global.character = "Granny" # add character name here

# callback function
func _process(_delta):
	# display overall score
	$TextureRect/MarginContainer2/Score.text = "Score: %d" % Global.overallScore

func _on_packitup_button_pressed():
	# debug message
	print("Level " + str(Global.levelCount) + " passed!")
	
	# storing score in placeholder int
	Global.scorekeeper = Global._calculateScore()
	
	# adding placeholder int to overall score
	Global.overallScore += Global.scorekeeper
	
	# adding placeholder int to score array
	Global.arr.push_back(Global.scorekeeper)
	
	# printing stars
	Global.stars = Global._calculateStars()
	
	# resetting placeholder int
	Global.scorekeeper = 0
	
	# change scene
	get_tree().change_scene_to_file("res://Scenes/Score/score_page.tscn")
