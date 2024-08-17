extends Node2D

var selected = false
var hovering = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if selected:
		followMouse()

#following mouse when pressed
func followMouse():
	position = get_global_mouse_position()


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#mouse left click pressed
		if event.pressed:
			selected = true
		#mouse left click released
		else:
			selected = false

func _input(event):
	#press S to shrink while moused over object
	if event.is_action_pressed("shrinkRay") and hovering == true:
		print("Entered small state")
		self.scale = Vector2(0.5, 0.5)
	#press E to enlarge while moused over object
	elif event.is_action_pressed("biggerRay") and hovering == true:
		self.scale = Vector2(1.5,1.5)


func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	hovering = true
	print(hovering)
