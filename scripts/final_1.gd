extends Area2D



func _on_body_entered(_body):
	Global.fase = 2
	assert(get_tree().change_scene_to_file("res://scenes/fase_2.tscn") == OK)
