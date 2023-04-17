extends CharacterBody2D



var speed = 200
var move_direction = 1
var gravity = 3000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity.x = speed * move_direction 
	velocity.y = gravity
	
	if move_direction == -1:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	if $RayCast2D.is_colliding():
		move_direction *= -1
		$RayCast2D.scale.x *= -1
		
	velocity.normalized()
	
	move_and_slide()
	


func _on_area_2d_body_entered(body):
	body.gameover()
