extends Control

@onready var slot_scene = preload("res://Scenes/Grid/slot.tscn")
@onready var item_scene = preload("res://Scenes/Grid/item.tscn")

@onready var grid_container = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/ScrollContainer/GridContainer
@onready var scroll_container = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/ScrollContainer
@onready var col_count = grid_container.columns

@onready var chest_container = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/ScrollContainer/ChestContainer
@onready var scroll_chest_container = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/ScrollContainer
@onready var col_count_chest = chest_container.columns

@onready var black_hole_sprite = $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/AnimatedSprite2D

@onready var text_value = %CurrValue
@onready var text_weight = %CurrWeight

@onready var curr_item_list = DataHandler.parsed_item_list.duplicate()

var item_held = null

var grid_array := []
var chest_array := []

var current_slot = null
var current_slot_chest = null

var can_place := false
var can_place_chest := false

var icon_anchor : Vector2
var icon_anchor_chest : Vector2

var current_value = 0
var current_weight = 0

var hand_open = load("res://Assets/MouseCursor/hand_open.png")
var hand_closed = load("res://Assets/MouseCursor/hand_closed.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
	for i in range(24):
		create_slot()
		
	# when create_slot_chest() i can add functionality to add items
	for i in range(600):
		create_slot_chest()
		# add items to slots
		#populate_chest()
	clear_grid()
	clear_grid_chest()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if item_held:
		if Input.is_action_just_pressed("rotate_item"):
			rotate_item()
		if Input.is_action_just_pressed("mouse_leftclick"):
			if scroll_container.get_global_rect().has_point(get_global_mouse_position()):
				place_item()
			if scroll_chest_container.get_global_rect().has_point(get_global_mouse_position()):
				place_item_chest()
		# If Shrink or Enlarge
		if Input.is_action_just_pressed("shrinkRay"):
			var new_item = item_scene.instantiate()
			add_child(new_item)
			new_item.load_item(item_held.item_ID.split("_")[0] + "_Small")
			built_to_scale_my_guy(new_item)
		if Input.is_action_just_pressed("biggerRay"):
			var new_item = item_scene.instantiate()
			add_child(new_item)
			new_item.load_item(item_held.item_ID.split("_")[0] + "_Large")
			built_to_scale_my_guy(new_item)
		if Input.is_action_just_pressed("defaultAgain"):
			var new_item = item_scene.instantiate()
			add_child(new_item)
			new_item.load_item(item_held.item_ID.split("_")[0])
			built_to_scale_my_guy(new_item)
	else:
		if Input.is_action_just_pressed("mouse_leftclick"):
			if scroll_container.get_global_rect().has_point(get_global_mouse_position()):
				pick_item()
			if scroll_chest_container.get_global_rect().has_point(get_global_mouse_position()):
				pick_item_chest()
func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	grid_container.add_child(new_slot)
	grid_array.push_back(new_slot)
	new_slot.slot_entered.connect(_on_slot_mouse_entered)
	new_slot.slot_exited.connect(_on_slot_mouse_exited)
	
func create_slot_chest():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = chest_array.size()
	chest_container.add_child(new_slot)
	chest_array.push_back(new_slot)
	new_slot.slot_entered.connect(_on_slot_mouse_entered_chest)
	new_slot.slot_exited.connect(_on_slot_mouse_exited_chest)
	

func _on_slot_mouse_entered(a_Slot):
	icon_anchor = Vector2(10000,10000)
	current_slot = a_Slot
	if item_held:
		check_slot_availability(current_slot)
		set_grids.call_deferred(current_slot)
		
func _on_slot_mouse_entered_chest(a_Slot):
	icon_anchor_chest = Vector2(10000,10000)
	current_slot_chest = a_Slot
	if item_held:
		check_slot_availability_chest(current_slot_chest)
		set_grids_chest.call_deferred(current_slot_chest)
	
func _on_slot_mouse_exited(a_Slot):
	clear_grid()
	
	if not grid_container.get_global_rect().has_point(get_global_mouse_position()):
		current_slot = null
		
func _on_slot_mouse_exited_chest(a_Slot):
	clear_grid_chest()
	
	if not chest_container.get_global_rect().has_point(get_global_mouse_position()):
		current_slot_chest = null
	
func _on_button_spawn_pressed() -> void:
	$spawning_item.play()
	
	 
	if item_held == null:
		Input.set_custom_mouse_cursor(hand_closed)
		var new_item = item_scene.instantiate()
		#new_item. = black_hole_sprite.global_position
		add_child(new_item)
		
		
		
		#curr_item_list is a mutable duplicate of our master list. 
		#check if its empty, then refresh loot pool
		if curr_item_list.is_empty(): 
			curr_item_list = DataHandler.parsed_item_list.duplicate()
		
		var curr_item = curr_item_list.pick_random()
		
		new_item.load_item(curr_item)
		new_item.selected = true
		item_held = new_item
		
		var curr_item_index = curr_item_list.find(curr_item)
		curr_item_list.remove_at(curr_item_index)
	
	
func check_slot_availability(a_Slot) -> void:
	for grid in item_held.item_grids:
		var grid_to_check = a_Slot.slot_ID + grid[0] + grid[1] * col_count
		var line_switch_check = a_Slot.slot_ID % col_count + grid[0]
		if line_switch_check < 0 or line_switch_check >= col_count:
			can_place = false
			return
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			can_place = false
			return
		if grid_array[grid_to_check].state == grid_array[grid_to_check].States.TAKEN:
			can_place = false
			return
	can_place = true
	
func check_slot_availability_chest(a_Slot) -> void:
	for grid in item_held.item_grids:
		var grid_to_check = a_Slot.slot_ID + grid[0] + grid[1] * col_count_chest
		var line_switch_check = a_Slot.slot_ID % col_count_chest + grid[0]
		if line_switch_check < 0 or  line_switch_check >= col_count_chest:
			can_place_chest = false
			return
		if grid_to_check < 0 or grid_to_check >= chest_array.size():
			can_place_chest = false
			return
		if chest_array[grid_to_check].state == chest_array[grid_to_check].States.TAKEN:
			can_place_chest = false
			return
	can_place_chest = true

func set_grids(a_Slot):
	for grid in item_held.item_grids:
		var grid_to_check = a_Slot.slot_ID + grid[0] + grid[1] * col_count
		var line_switch_check = a_Slot.slot_ID % col_count + grid[0]
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			continue
		if line_switch_check < 0 or line_switch_check >= col_count:
			continue
		if can_place:
			grid_array[grid_to_check].set_color(grid_array[grid_to_check].States.FREE)
			
			if grid[1] < icon_anchor.x: icon_anchor.x = grid[1]
			if grid[0] < icon_anchor.y: icon_anchor.y = grid[0]
		else:
			grid_array[grid_to_check].set_color(grid_array[grid_to_check].States.TAKEN)
			
func set_grids_chest(a_Slot):
	for grid in item_held.item_grids:
		var grid_to_check = a_Slot.slot_ID + grid[0] + grid[1] * col_count_chest
		var line_switch_check = a_Slot.slot_ID % col_count_chest + grid[0]
		if grid_to_check < 0 or grid_to_check >= chest_array.size():
			continue
		if line_switch_check < 0 or line_switch_check >= col_count_chest:
			continue
		if can_place_chest:
			chest_array[grid_to_check].set_color(chest_array[grid_to_check].States.FREE)
			
			if grid[1] < icon_anchor_chest.x: icon_anchor_chest.x = grid[1]
			if grid[0] < icon_anchor_chest.y: icon_anchor_chest.y = grid[0]
		else:
			chest_array[grid_to_check].set_color(chest_array[grid_to_check].States.TAKEN)

func clear_grid():
	for grid in grid_array:
		grid.set_color(grid.States.DEFAULT)
		
func clear_grid_chest():
	for grid in chest_array:
		grid.set_color(grid.States.DEFAULT)
		
func rotate_item():
	item_held.rotate_item()
	$item_rotate.play()
	clear_grid()
	clear_grid_chest()
	if current_slot:
		_on_slot_mouse_entered(current_slot)
	if current_slot_chest:
		_on_slot_mouse_entered_chest(current_slot_chest)

func place_item():
	$item_place.play()
	if not can_place or not current_slot:
		return 
	var calculated_grid_id = current_slot.slot_ID + icon_anchor.x * col_count + icon_anchor.y
	item_held._snap_to(grid_array[calculated_grid_id].global_position)
	item_held.get_parent().remove_child(item_held)
	grid_container.add_child(item_held)
	item_held.global_position = get_global_mouse_position()
	
	item_held.grid_anchor = current_slot
	for grid in item_held.item_grids:
		var grid_to_check = current_slot.slot_ID + grid[0] + grid[1] * col_count
		grid_array[grid_to_check].state = grid_array[grid_to_check].States.TAKEN
		grid_array[grid_to_check].item_stored = item_held
		
	current_value += item_held.item_value
	current_weight += item_held.item_weight
	text_value.text = "Current Value of Grid: " + str(current_value)
	text_weight.text = "Current Weight of Grid: " + str(current_weight)
		
	item_held = null
	Input.set_custom_mouse_cursor(hand_open)
	clear_grid()
	
func place_item_chest():
	$item_place.play()
	if not can_place_chest or not current_slot_chest:
		return 
		
	var calculated_grid_id = current_slot_chest.slot_ID + icon_anchor_chest.x * col_count_chest + icon_anchor_chest.y
	item_held._snap_to(chest_array[calculated_grid_id].global_position)

	item_held.get_parent().remove_child(item_held)
	chest_container.add_child(item_held)
	item_held.global_position = get_global_mouse_position()
	
	item_held.grid_anchor = current_slot_chest
	for grid in item_held.item_grids:
		var grid_to_check = current_slot_chest.slot_ID + grid[0] + grid[1] * col_count_chest
		chest_array[grid_to_check].state = chest_array[grid_to_check].States.TAKEN
		chest_array[grid_to_check].item_stored = item_held
		
	Input.set_custom_mouse_cursor(hand_open)	
	item_held = null
	clear_grid_chest()

func pick_item():
	$item_interact.play()
	if not current_slot or not current_slot.item_stored:
		return
	
	Input.set_custom_mouse_cursor(hand_closed)
		
	item_held = current_slot.item_stored
	item_held.selected = true
	
	item_held.get_parent().remove_child(item_held)
	add_child(item_held)
	item_held.global_position = get_global_mouse_position()
	
	for grid in item_held.item_grids:
		var grid_to_check = item_held.grid_anchor.slot_ID + grid[0] + grid[1] * col_count
		grid_array[grid_to_check].state = grid_array[grid_to_check].States.FREE
		grid_array[grid_to_check].item_stored = null
		
	current_value -= item_held.item_value
	current_weight -= item_held.item_weight
	text_value.text = "Current Value of Grid: " + str(current_value)
	text_weight.text = "Current Weight of Grid: " + str(current_weight)
		
	check_slot_availability(current_slot)
	set_grids.call_deferred(current_slot)

func pick_item_chest():
	$item_interact.play()
	if not current_slot_chest or not current_slot_chest.item_stored:
		return
		
	Input.set_custom_mouse_cursor(hand_closed)		
	item_held = current_slot_chest.item_stored
	item_held.selected = true
	
	item_held.get_parent().remove_child(item_held)
	add_child(item_held)
	item_held.global_position = get_global_mouse_position()
	
	for grid in item_held.item_grids:
		var grid_to_check = item_held.grid_anchor.slot_ID + grid[0] + grid[1] * col_count_chest
		chest_array[grid_to_check].state = chest_array[grid_to_check].States.FREE
		chest_array[grid_to_check].item_stored = null
		
	check_slot_availability_chest(current_slot_chest)
	set_grids_chest.call_deferred(current_slot_chest)
	#
#func populate_chest():
	#var new_item = item_scene.instantiate()
	#add_child(new_item)
	#new_item.load_item(str(randi_range(1, 4)))
	
func _on_packitup_button_pressed():
	$spawning_item.play()
	# debug message
	print("Level " + str(Global.levelCount) + " passed!")
	# calc score goes here
	Global.overallScore += current_value
	Global.arr.push_back(current_value)
	Global.stars = Global._calculateStars(current_value)
	
	# change scene
	get_tree().change_scene_to_file("res://Scenes/Score/score_page.tscn")
	
func built_to_scale_my_guy(new_item):
	$change_size.play()
	new_item.selected = true
	remove_child(item_held)
	item_held = new_item
	clear_grid()
	clear_grid_chest()
	if current_slot:
		_on_slot_mouse_entered(current_slot)
	if current_slot_chest:
		_on_slot_mouse_entered_chest(current_slot_chest)
		
