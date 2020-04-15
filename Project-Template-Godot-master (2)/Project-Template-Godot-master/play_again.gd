extends Button



func _on_play_again_toggled(button_pressed):
	get_tree().change_scene("res://Spatial.tscn")


func _on_reset_pressed():
	get_tree().change_scene()
