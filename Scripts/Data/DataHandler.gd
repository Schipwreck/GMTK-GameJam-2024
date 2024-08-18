extends Node

var item_data := {}
var item_grid_data := {}
var parsed_item_list := []

@onready var item_data_path = "res://Data/Item_data.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data(item_data_path)
	set_grid_data()

func load_data(a_path) -> void:
	if not FileAccess.file_exists(a_path):
		print("Item data file not found")
	var item_data_file = FileAccess.open(a_path, FileAccess.READ)
	item_data = JSON.parse_string(item_data_file.get_as_text())
	parsed_item_list = item_data.keys()
	item_data_file.close()
	
func set_grid_data():
	for item in item_data.keys():
		var temp_grid_array := []
		for point in item_data[item]["Grid"].split("/"):
			temp_grid_array.push_back(point.split(","))
		item_grid_data[item] = temp_grid_array
	print(item_grid_data)
