extends CharacterBody2D

var speed = 150
@onready var can_attack = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Global.player != null:
		velocity = global_position.direction_to(Global.player.global_position)
		if can_attack:
			global_position += velocity * speed * delta

func _on_area_2d_body_entered(body):
	if body.get_scene_file_path() == "res://scenes/Spark.tscn" and can_attack:
		body.gameover()
	elif body.get_scene_file_path() == "res://scenes/Bullet.tscn":
		can_attack = false
		$Stun_cooldown.start()



func _on_stun_cooldown_timeout():
	can_attack = true
