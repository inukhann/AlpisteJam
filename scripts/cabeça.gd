extends CharacterBody2D

enum{ SHOOT, STOP}
@onready var ProjetilInstance = preload("res://scenes/projetil.tscn")
var STATUS

# Called when the node enters the scene tree for the first time.
func _ready():
	STATUS = STOP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if STATUS == SHOOT:
		pass





func _on_area_2d_body_entered(_body):
	STATUS = SHOOT
	$Timer.start()
	
	
	
	
func shoot():
	var projetil = ProjetilInstance.instantiate()
	add_child(projetil)
	projetil.global_position = $spawn_shoot.global_position
	


func _on_area_2d_body_exited(_body):
	STATUS = STOP
	$Timer.stop()
	$Timer.set_wait_time(3)


func _on_timer_timeout():
	shoot()


func _on_morre_desgraa_body_entered(_body):
	queue_free()


func _on_kill_player_body_entered(body):
	if body.get_scene_file_path() == "res://scenes/Spark.tscn":
		body.gameover()
	elif body.get_scene_file_path() == "res://scenes/Bullet.tscn":
		$Stun_cooldown.start()
