extends CanvasLayer

@onready var pausemenu = $pausemenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	if Input.is_action_pressed("ui_cancel"):
		pausemenu.visible = true
		get_tree().paused = true


func _on_resume_pressed():
	pausemenu.visible = false
	get_tree().paused = false


func _on_quit_pressed():
	get_tree().quit()
