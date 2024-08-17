extends Node2D

var selected = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		followMouse()

#following mouse when pressed
func followMouse():
	position = get_global_mouse_position()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#mouse left click pressed
		if event.pressed:
			selected = true
		#mouse left click released
		else:
			selected = false
