extends Area2D


var speed = 200
var velocity = Vector2.ZERO
var move_direction = -1

func _physics_process(delta):
	velocity.x = speed * delta * move_direction
	
	translate(velocity)


func _on_clear_node_screen_exited():
	queue_free()


func _on_body_entered(body):
	body.gameover()
