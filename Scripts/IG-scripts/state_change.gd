extends Label  # or whatever type your item is (e.g., Sprite or RigidBody2D)
# TextureRect(), mouse_entered()

#add functionality for tracking number of charges of shrink and enlarge ray

# Enum for the states
enum State { DEFAULT, SMALL, LARGE }

# The current state of the item
var current_state = State.DEFAULT

# Ready function (set up initial state)
func _ready():
	change_state(State.DEFAULT)  # Start in the default state

# Function to change the state
func change_state(new_state):
	# Check if we’re already in the requested state
	if new_state == current_state:
		return
	# Update the current state
	current_state = new_state
	print("State changed to:", current_state)

	# Handle what happens in each state
	match current_state:
		State.DEFAULT:
			handle_default_state()
		State.SMALL:
			handle_small_state()
		State.LARGE:
			handle_large_state()

# Functions to handle each state
func handle_default_state():
	# Handle the default state logic here
	print("Entered default state")
	# For example: Set the scale or any specific logic
	self.scale = Vector2(1, 1)  # Normal size
	# Add more logic related to the default state

func handle_small_state():
	# Handle the small state logic here
	print("Entered small state")
	self.scale = Vector2(0.5, 0.5)  # Shrink to half size
	# Add more logic for small state

func handle_large_state():
	# Handle the large state logic here
	print("Entered large state")
	self.scale = Vector2(2, 2)  # Grow to double size
	# Add more logic for large state

# Sample function to transition between states (can be called via input or events)
func _input(event):
	if event.is_action_pressed("shrinkRay"):  # Example input
		change_state(State.SMALL)  # Switch to small state
	elif event.is_action_pressed("biggerRay"):
		change_state(State.LARGE)  # Switch to large state
	elif event.is_action_pressed("defaultAgain"):
		change_state(State.DEFAULT)  # Switch back to default state
