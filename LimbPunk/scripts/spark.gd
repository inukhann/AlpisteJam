extends CharacterBody2D

enum Status {
	NORMAL, ARMLESS, LEGLESS, LIMBLESS, BODYLESS
}

const base_velocity_x = 100
const base_velocity_y = 200
const GRAVITY = 10
@onready var can_shoot = true
@onready var can_dash = false
@onready var char_state = Status.NORMAL
@onready var velocity_mod_x = 1
@onready var velocity_mod_y = 1


func _physics_process(delta):
	change_status()
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
	else:
		velocity.x = 0
	
func move_character_y():
	if char_state != Status.BODYLESS:
		if Input.is_action_pressed("JUMP") and is_on_floor():
			velocity.y = (velocity_mod_y * -base_velocity_y)
		else:
			velocity.y += GRAVITY
	else:
		if Input.is_action_pressed("JUMP"):
			velocity.y = (velocity_mod_y * -base_velocity_y)
		elif Input.is_action_pressed("MOVE_DOWN"):
			velocity.y = (velocity_mod_y * base_velocity_x)
		else:
			velocity.y = 0
			
			
func change_status():
	if Input.is_action_pressed("DETACH_HEAD"):
		detach_head()
	if Input.is_action_pressed("DETACH_LIMBS"):
		detach_arms()
		detach_legs()
	if Input.is_action_pressed("DETACH_ARMS"):
		detach_arms()
	if Input.is_action_pressed("DETACH_LEGS"):
		detach_legs()
	#aqui poderiamos fazer a mudança de sprite do char tbm
	
func detach_arms():
	if char_state == Status.NORMAL or char_state == Status.LEGLESS:
		can_dash = true
		can_shoot = false
		if char_state == Status.LEGLESS:
			char_state = Status.LIMBLESS
		else:
			char_state = Status.ARMLESS
		#aqui mudaria algo da sprite, a ser feito ainda.

func detach_legs():
	if char_state == Status.NORMAL or char_state == Status.ARMLESS:
		if char_state == Status.ARMLESS:
			velocity_mod_x = 0
			char_state = Status.LIMBLESS
		else:
			velocity_mod_x = 0.5
			char_state = Status.LEGLESS
		velocity_mod_y = 2
		#aqui mudaria algo da sprite, a ser feito ainda.

func detach_head():
	velocity_mod_x = 1.2
	velocity_mod_y = 1.2
	char_state = Status.BODYLESS
	$Fuel_timer.start()


func gameover():
	queue_free()
	assert(get_tree().change_scene_to_file("res://scenes/gameover.tscn") == OK)


func _on_fuel_timer_timeout():
	gameover()
