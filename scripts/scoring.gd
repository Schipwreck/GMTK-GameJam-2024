extends Control


var score = 0
@onready var scoreLabel = $Score


func _ready():
	pass


func _process(delta):
	score = 1337
	scoreLabel.text = "Score: %d" % score
