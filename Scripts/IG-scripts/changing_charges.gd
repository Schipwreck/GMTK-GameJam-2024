extends Node2D

@onready var label = $Label
var shrink_charges = 4
var enlarge_charges = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str("You have ") + str(shrink_charges) + str(" shrink charges left")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shrinkRay"):
		shrink_charges -= 1
		label.text = str("You have ") + str(shrink_charges) + str(" shrink charges left")
