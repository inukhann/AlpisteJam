extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fase = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/fase_1.tscn")


func _on_exit_pressed():
	get_tree().quit()
