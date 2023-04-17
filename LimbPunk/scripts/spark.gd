extends CharacterBody2D

enum Status {
	NORMAL, ARMLESS, LEGLESS, LIMBLESS, BODYLESS
}

const base_velocity_x = 100
const base_velocity_y = 100
const GRAVITY = 10
@onready var char_state = Status.NORMAL
@onready var velocity_mod_x = 1
@onready var velocity_mod_y = 1


func _physics_process(delta):
	move_character_x()
	move_character_y()
	move_and_slide()
	

func move_character_x():
	if char_state != Status.LIMBLESS:
		if Input.is_action_pressed("MOVE_RIGHT"):
			velocity.x = (velocity_mod_x * base_velocity_x)
		elif Input.is_action_pressed("MOVE_LEFT"):
			velocity.x = (velocity_mod_x * -base_velocity_x)
		else:
			velocity.x = 0
	
func move_character_y():
	if char_state == Status.NORMAL:
		if Input.is_action_pressed("JUMP"):
			velocity.y = (velocity_mod_y * -base_velocity_y)
		else:
			velocity.y += GRAVITY
		
