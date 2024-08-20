extends Node

# global vars
var overallScore = 0
var levelCount = 1
var arr = [] # to hold scores from previous levels
var stars = 0
var scorekeeper = 0
var character = ""

# score logic
func _calculateScore():
	# adjust these below in their respective match cases
	var weight = 1
	var weightModifier = 1
	var value = 1
	var valueModifier = 1
	var score = 0
	
	# add other matches for other characters
	# you don't need to add break statements at the end of every block
	# match cases automatically break out of every block by nature in GDscript
	# use continue if you want to iterate through the next block
	match Global.character:
		"Granny":
			weightModifier = 2.5
			valueModifier = 2.5

	score = (weight * weightModifier) + (value * valueModifier)
	return score


func _calculateStars(current_value):
	# adjust these values when needed
	if (current_value >= 500):
		stars = 5
		return stars
	if (current_value >= 400):
		stars = 4
		return stars
	if (current_value >= 300):
		stars = 3
		return stars
	if (current_value >= 200):
		stars = 2
		return stars
	if (current_value >= 100):
		stars = 1
		return stars
	if (current_value >= 0):
		stars = 0
		return stars
