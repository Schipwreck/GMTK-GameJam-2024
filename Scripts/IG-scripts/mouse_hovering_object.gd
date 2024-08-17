extends CollisionShape2D

var input_pickable = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func mouse_entered():
	print("Mouse is over the object")
	# You can change the visual appearance, scale, or do something else here
	# Example: Change the scale to indicate hovering
	self.scale = Vector2(1.2, 1.2)  # Slightly larger when hovered

# Function that runs when the mouse stops hovering over the object
func mouse_exited():
	print("Mouse exited the object")
	# Reset the appearance or do something else
	self.scale = Vector2(1, 1)  # Reset size when mouse exits
	
