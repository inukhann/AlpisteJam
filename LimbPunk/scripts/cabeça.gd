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
		$Timer.get_wait_time()





func _on_area_2d_body_entered(_body):
	STATUS = SHOOT
	
	
	
func shoot():
	var projetil = ProjetilInstance.instantiate()
	add_child(projetil)
	projetil.global_position = $spawn_shoot.global_position
	


func _on_area_2d_body_exited(_body):
	STATUS = STOP


func _on_timer_timeout():
	shoot()
