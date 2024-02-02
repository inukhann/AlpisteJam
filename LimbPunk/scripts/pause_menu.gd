extends CanvasLayer

@onready var pausemenu = $pausemenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pausemenu.visible = false
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("PAUSE"):
		pausemenu.visible = not pausemenu.visible
		get_tree().paused = not get_tree().paused


func _on_resume_pressed():
	pausemenu.visible = false
	get_tree().paused = false


func _on_quit_pressed():
	get_tree().quit()
