extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/fase_1.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()
