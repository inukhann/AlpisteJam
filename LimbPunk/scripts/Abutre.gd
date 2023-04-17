extends CharacterBody2D


var speed = 150
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Global.player != null:
		velocity = global_position.direction_to(Global.player.global_position)
		
		global_position += velocity * speed * delta


func _on_area_2d_body_entered(body):
	body.gameover()
