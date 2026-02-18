extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var coins_collected = 0 # used in coin.gd, kinda weird i have to put this here like an object property, but it works for now. maybe i can refactor this later

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var double_jump = true
	var is_dead = false

	# Death indicator will come from killzone.gd
	if is_dead:
		velocity.y += 1000 * delta
		move_and_slide()
		return
		
	# Apply [gravity, double jump] during air time.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif not is_dead:
		double_jump = true
	
	# Handle jump, you need to configure [jump, move_left, move_right] in:
	# Project -> Project Settings -> Input Map

	# todo: jump/double jump animation is not working for some reason, need to fix that
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			animated_sprite_2d.animation = "jump"
		elif double_jump:
			velocity.y = JUMP_VELOCITY
			double_jump = false
			animated_sprite_2d.animation = "double_jump"
			

	# Handle sprite movement direction
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		animated_sprite_2d.flip_h = (direction == -1)
		velocity.x = direction * SPEED	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor():
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"
	move_and_slide()


func handle_movement() -> void:
	#todo: refactor movement code here
	pass

func handle_animation() -> void:
	# todo: refactor animation code here
	pass
