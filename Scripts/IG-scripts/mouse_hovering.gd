extends TextureRect

signal box_hover(hover)
signal box_no_hover(hover)

var is_hovering := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_global_rect().has_point(get_global_mouse_position()):
		if not is_hovering:
			is_hovering = true
			print("this is box")
			emit_signal("box_hover",self)
	else:
		if is_hovering:
			is_hovering = false
			print("this is no longer a box")
			emit_signal("box_no_hover",self)
