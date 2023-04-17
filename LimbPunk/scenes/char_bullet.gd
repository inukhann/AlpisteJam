extends CharacterBody2D

var direction
const SPEED = 400

func _physics_process(delta):
	move_and_slide()
	
func change_target(target):
	if target is Vector2:
		direction = (target - position).normalized()
		rotate(direction.angle())
		set_velocity(direction * SPEED)
		
func hit_target():
	queue_free()

func _on_lifetime_timeout():
	queue_free()
