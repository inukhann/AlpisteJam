extends CharacterBody2D


var speed = 200
var move_direction = 1
var gravity = 3000
@onready var can_attack = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity.x = speed * move_direction 
	velocity.y = gravity
	
	if move_direction == -1:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	
	if $RayCast2D.is_colliding():
		move_direction *= -1
		$RayCast2D.scale.x *= -1
		
	velocity.normalized()
	
	if can_attack:
		move_and_slide()
	

func _on_area_2d_body_entered(body):
	if body.get_path() == "res://scenes/Spark.tscn" and can_attack:
		body.gameover()
	elif body.get_path() == "res://scenes/Bullet.tscn":
		can_attack = false
