extends Control

@onready var main = $"../.."
var SFX: StringName
var Music: StringName
var Music_index = 1
var SFX_index = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/HBoxContainer3/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	$MarginContainer/VBoxContainer/HBoxContainer2/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))

func _on_resume_pressed() -> void:
	main.pauseMenu()
	

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	pass # Replace with function body.


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	pass # Replace with function body.


func _on_music_slider_mouse_exited() -> void:
	self.release_focus()


func _on_sfx_slider_mouse_exited() -> void:
	self.release_focus()
