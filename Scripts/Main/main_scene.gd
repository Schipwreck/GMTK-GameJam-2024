extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var concept_ui = $CanvasLayer3/ConceptUI

var paused = false

func _ready():
	Global.character = "Granny" # add character name here
	
	concept_ui.grid_container.columns = 6
	concept_ui.col_count = 6
	for i in range(24):
		concept_ui.create_slot()
		
	concept_ui.clear_grid()

# callback function
func _process(_delta):
	# display overall score
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
	# debug message
	TransitionScene.transition()
	await TransitionScene.on_transition_finished
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


func _on_button_pressed() -> void:
	$sfx.play()
