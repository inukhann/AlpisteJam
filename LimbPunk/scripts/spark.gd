extends CharacterBody2D

enum Status {
	NORMAL, ARMLESS, LEGLESS, LIMBLESS, BODYLESS
}

var char_state
var base_velocity = 100
@onready var velocity_mod = 1

func _ready():
	apply_central_force()

func _physics_process(delta):
	move_character()
	move_and_slide()
	

func move_character():
	if Input.is_action_pressed("MOVE_RIGHT"):
		set_velocity(Vector2.RIGHT * velocity_mod * base_velocity)
	elif Input.is_action_pressed("MOVE_LEFT"):
		set_velocity(Vector2.LEFT * velocity_mod * base_velocity)
	else:
		set_velocity(Vector2.ZERO)
