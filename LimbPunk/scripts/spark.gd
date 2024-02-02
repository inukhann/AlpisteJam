extends CharacterBody2D

enum Status {
	NORMAL, ARMLESS, LEGLESS, LIMBLESS, BODYLESS, DEAD, DEFAULT
}

const MAX_HEAD_VEL = 300
const BASE_VELOCITY_X = 180
const BASE_VELOCITY_Y = 300
const GRAVITY = 10
@onready var on_cooldown = false
@onready var can_shoot = true
@onready var can_dash = false
@onready var has_dashed = false
@onready var char_state = Status.NORMAL
@onready var velocity_mod_x = 1
@onready var velocity_mod_y = 1
@onready var bullet_instance = preload("res://scenes/Bullet.tscn")
var move_direction = -1
var canJump = true

func _ready():
	$ProgressBar.hide()
	Global.player = self
	$Normal_Sprite/AnimationPlayer.queue("Idle")
	$Leg_Torso_Arm_Collision.set_disabled(false)
	$Leg_Torso_Collision.set_disabled(true)
	$Torso_Collision.set_disabled(true)
	$Head_Collision.set_disabled(true)
	
	$Normal_Sprite/Torso/ArmLeft.show()
	$Normal_Sprite/Torso/ArmRight.show()
	$Normal_Sprite/Torso/LegLeft.show()
	$Normal_Sprite/Torso/LegRight.show()
	$Normal_Sprite/Torso/Body.show()

	
	
func _physics_process(_delta):
	if char_state == Status.DEAD:
		pass
		
	else:
		change_status()
		shoot_bullet()
		move_character_x()
		move_character_y()
		move_and_slide()
	
func move_character_x():
	if can_dash and !has_dashed and Input.is_action_just_pressed("DASH") and !on_cooldown:
		var aux_mod = velocity_mod_x
		if Input.is_action_pressed("MOVE_LEFT"):
			aux_mod = -4
			has_dashed = true
		elif Input.is_action_pressed("MOVE_RIGHT"):
			aux_mod = 4
			has_dashed = true
		else:
			aux_mod = -4 * move_direction
			has_dashed = true
		velocity.x = (aux_mod * BASE_VELOCITY_X)
	elif has_dashed:
		if velocity.x < BASE_VELOCITY_X * -velocity_mod_x:
			velocity.x += 10
		elif velocity.x > BASE_VELOCITY_X * velocity_mod_x:
			velocity.x -= 10
		else:
			has_dashed = false
			on_cooldown = true
			$Dash_cooldown.start()
	else:
		if char_state != Status.LIMBLESS and char_state != Status.BODYLESS:
			if Input.is_action_pressed("MOVE_RIGHT"):
				move_direction = -1
				velocity.x = (velocity_mod_x * BASE_VELOCITY_X)
				if !$Normal_Sprite/AnimationPlayer.get_current_animation() == "Jump" and is_on_floor():
					queue_anim("Run")
			elif Input.is_action_pressed("MOVE_LEFT"):
				move_direction = 1
				velocity.x = (velocity_mod_x * -BASE_VELOCITY_X)
				if !$Normal_Sprite/AnimationPlayer.get_current_animation() == "Jump" and is_on_floor():
					queue_anim("Run")
			else:
				velocity.x = 0
				if !$Normal_Sprite/AnimationPlayer.get_current_animation() == "Jump" and is_on_floor():
					queue_anim("Idle")
		elif char_state == Status.BODYLESS:
			if Input.is_action_pressed("MOVE_RIGHT") and velocity.x < MAX_HEAD_VEL:
				velocity.x += 10
			elif Input.is_action_pressed("MOVE_LEFT") and velocity.x > -MAX_HEAD_VEL:
				velocity.x -= 10
			else:
				velocity.x -= velocity.x / 10
		else:
			velocity.x = 0
			
	
func move_character_y():
	coyoteEffect()
	if char_state != Status.BODYLESS:
		if Input.is_action_just_pressed("JUMP") and canJump:
			queue_anim("Jump")
			velocity.y = (velocity_mod_y * -BASE_VELOCITY_Y)
		elif Input.is_action_just_released("JUMP") and velocity.y < - BASE_VELOCITY_Y * 0.1:
			velocity.y = (velocity_mod_y * -BASE_VELOCITY_Y) * 0.1
		elif Input.is_action_pressed("JUMP") and canJump:
			velocity.y = (velocity_mod_y * -BASE_VELOCITY_Y)
		else:
			velocity.y += GRAVITY
	else:
		if Input.is_action_pressed("up") and velocity.y > -MAX_HEAD_VEL:
			velocity.y -= 10
		elif Input.is_action_pressed("MOVE_DOWN") and velocity.y < MAX_HEAD_VEL:
			velocity.y += 10
		else:
			velocity.y -= velocity.y / 10
			
func change_status():
	if Input.is_action_just_pressed("DETACH_HEAD"):
		detach_head()
	if Input.is_action_just_pressed("DETACH_LIMBS"):
		detach_arms()
		detach_legs()
	if Input.is_action_just_pressed("DETACH_ARMS"):
		detach_arms()
	if Input.is_action_just_pressed("DETACH_LEGS"):
		detach_legs()
	#aqui poderiamos fazer a mudança de sprite do char tbm
	
func shoot_bullet():
	if can_shoot and Input.is_action_just_pressed("SHOOT"):
		var fired = bullet_instance.instantiate()
		get_parent().add_child(fired)
		if fired.has_method("change_target"):
			fired.change_target(get_global_mouse_position(), self.global_position)
		can_shoot = false
		$Bullet_cooldown.start()
	
func detach_arms():
	if char_state == Status.NORMAL or char_state == Status.LEGLESS:
		can_dash = true
		can_shoot = false
		$"BraçoFX".play()
		if char_state == Status.LEGLESS:
			velocity_mod_x = 0
			char_state = Status.LIMBLESS
		else:
			char_state = Status.ARMLESS
			$Leg_Torso_Arm_Collision.set_disabled(true)
			$Leg_Torso_Collision.set_disabled(false)
		$Normal_Sprite/Torso/ArmLeft.hide()
		$Normal_Sprite/Torso/ArmRight.hide()
		$Normal_Sprite/AnimationPlayer.stop()
		$KillEnemy.set_monitoring(false)

func detach_legs():
	if char_state == Status.NORMAL or char_state == Status.ARMLESS:
		$PernasFX.play()
		if char_state == Status.ARMLESS:
			velocity_mod_x = 0
			char_state = Status.LIMBLESS
			$Leg_Torso_Collision.set_disabled(true)
			$Torso_Collision.set_disabled(false)
		else:
			velocity_mod_x = 0.5
			char_state = Status.LEGLESS
			$Leg_Torso_Arm_Collision.set_disabled(true)
			$Torso_Collision.set_disabled(false)
		velocity_mod_y = 1.5
		$Normal_Sprite/Torso/LegLeft.hide()
		$Normal_Sprite/Torso/LegRight.hide()
		$Normal_Sprite/AnimationPlayer.stop()
		$KillEnemy.set_monitoring(false)

func detach_head():
	if char_state != Status.BODYLESS:
		$ProgressBar.show()
		$ProgressBar/progressTime.start()
		$"CabeçaFX".play()
		can_shoot = false
		can_dash = false
		velocity_mod_x = 1.2
		velocity_mod_y = 1.2
		char_state = Status.BODYLESS
		
		$Leg_Torso_Arm_Collision.set_disabled(true)
		$Leg_Torso_Collision.set_disabled(true)
		$Torso_Collision.set_disabled(true)
		$Head_Collision.set_disabled(false)
		
		$Normal_Sprite/Torso/ArmLeft.hide()
		$Normal_Sprite/Torso/ArmRight.hide()
		$Normal_Sprite/Torso/LegLeft.hide()
		$Normal_Sprite/Torso/LegRight.hide()
		$Normal_Sprite/Torso/Body.hide()
		
		$Normal_Sprite/AnimationPlayer.stop()
		$KillEnemy.set_monitoring(false)
		
		$Fuel_timer.start()


func gameover():
	$Normal_Sprite/Torso/ArmLeft.hide()
	$Normal_Sprite/Torso/ArmRight.hide()
	$Normal_Sprite/Torso/LegLeft.hide()
	$Normal_Sprite/Torso/LegRight.hide()
	$Normal_Sprite/Torso/Body.hide()
	$Normal_Sprite/Torso/Head.hide()
	char_state = Status.DEAD
	$TimerMorte.start()
	print("a")
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")


func _on_fuel_timer_timeout():
	gameover()


func _on_dash_cooldown_timeout():
	on_cooldown = false


func _on_bullet_cooldown_timeout():
	can_shoot = true
	
func queue_anim(queued):
	if !$Normal_Sprite/AnimationPlayer.get_current_animation() == queued:
		$Normal_Sprite/AnimationPlayer.play(queued)


func _on_progress_time_timeout():
	$ProgressBar.value -= 1


func _on_timer_morte_timeout():
	queue_free()
	assert(get_tree().reload_current_scene() == OK)


func _on_coyote_timer_timeout():
	canJump = false

func coyoteEffect():
	if is_on_floor():
		canJump = true
	elif canJump and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start()


func _on_kill_enemy_body_entered(body):
	canJump = true
	velocity_mod_y *= 1.5
	$KillEnemy/TimerKillJump.start()
	body.queue_free()


func _on_timer_kill_jump_timeout():
	velocity_mod_y = 1
	canJump = false
	

	
