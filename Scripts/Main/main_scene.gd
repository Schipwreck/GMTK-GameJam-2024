extends Node2D


func _on_packitup_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Score/score_page.tscn")
