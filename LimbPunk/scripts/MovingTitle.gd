extends Sprite2D

var t

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	t = 0.001

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	t = t + 0.02
	self.position.y = self.position.y + (0.08 * sin(t))
	

