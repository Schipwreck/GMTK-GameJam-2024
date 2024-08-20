extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var concept_ui = $CanvasLayer3/ConceptUI
var paused = false

func _ready():
	Global.character = "" # add character name here

# callback function
func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		concept_ui.get_tree().paused = false
		Engine.time_scale = 1
	else:
		pause_menu.show()
		concept_ui.get_tree().paused = true
		Engine.time_scale = 0
		
	paused = !paused

func _on_packitup_button_pressed():
	TransitionScene.transition()
	await TransitionScene.on_transition_finished
	# debug msg
	print("Level " + str(Global.levelCount) + " passed!")
	
	## storing score in placeholder int
	#Global.scorekeeper = Global._calculateScore()
	#
	## adding placeholder int to overall score
	#Global.overallScore += Global.scorekeeper
	#
	## adding placeholder int to score array
	#Global.arr.push_back(Global.overallScore)
	#
	## printing stars
	#Global.stars = Global._calculateStars()
	#
	## resetting placeholder int
	#Global.scorekeeper = 0
	
	# change scene
	get_tree().change_scene_to_file("res://Scenes/Score/score_page.tscn")
