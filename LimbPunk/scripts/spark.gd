extends CharacterBody2D

var base_velocity = 10
@onready var velocity_mod = 1

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("MOVE_RIGHT"):
		set_velocity(Vector2.RIGHT * velocity_mod * base_velocity)
	elif Input.is_action_pressed("MOVE_LEFT"):
		set_velocity(Vector2.LEFT * velocity_mod * base_velocity)
	else:
		set_velocity(Vector2.ZERO)
	move_and_slide()

