extends Control
 

func _ready() -> void:
	$SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	$MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	pass


func _on_start_button_pressed():
	TransitionScene.transition()
	await TransitionScene.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main/main_scene.tscn")
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.



func _on_sfx_button_pressed() -> void:
	$sfx.play()
	
	
var SFX: StringName
var Music: StringName
var music_index = 1
var sfx_index = 2




func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_index,
	linear_to_db(value))
	





func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_index,
	linear_to_db(value))


func _on_music_slider_mouse_exited() -> void:
	self.release_focus()


func _on_sfx_slider_mouse_exited() -> void:
	self.release_focus()
