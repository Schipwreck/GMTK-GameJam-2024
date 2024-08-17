extends Label

var overallScore = 0 # overallScore is what is displayed in UI
@onready var score_label = $score_label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score_label.text = "Score: %d" % overallScore
	

func _calculateScore():
	var currentScore = 0
	# get gridspace state, return # of tiles in total (ptr 1)
	# get gridspace state, return # of tiles filled (ptr 2)
	# subtract gridspace ptr 2 from ptr 1 (int 1)
	# score += flat amt of points * ptr 2 value
	# subtract (flat amt of pts * int 1) from score
	# get items state, return # of items given in total (ptr 3)
	# get items state, return # of items used in total (ptr 4)
	# subtract ptr 4 from ptr 3 (int 2)
	# subtract (flat amt of pts * int 2) from score
	# currentScore = final number
	# call update score method, passing in currentScore value
	pass
	
func _updateScore(currentScore):
	# overallScore += currentScore?
	pass
