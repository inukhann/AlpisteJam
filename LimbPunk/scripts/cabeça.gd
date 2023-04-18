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
	$Timer.start(1)
	
	
	
func shoot():
	var projetil = ProjetilInstance.instantiate()
	add_child(projetil)
	projetil.global_position = $spawn_shoot.global_position
	


func _on_area_2d_body_exited(_body):
	STATUS = STOP
	$Timer.stop()


func _on_timer_timeout():
	shoot()


func _on_morre_desgraa_body_entered(body):
	queue_free()
