extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	#get_tree().change_scene_to_file("res://scenes/fase_2.tscn")
	pass

func _on_resart_pressed():
	if Global.fase == 1:
		get_tree().change_scene_to_file("res://scenes/fase_1.tscn")
	else: 
		get_tree().change_scene_to_file("res://scenes/fase_2.tscn")


func _on_quit_pressed():
	get_tree().quit()
