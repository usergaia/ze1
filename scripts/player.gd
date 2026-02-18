extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var double_jump = true
var is_dead = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

func _physics_process(delta: float) -> void:
	if is_dead:
		handle_death(delta)
		return

	handle_gravity(delta)
	handle_jump()
	handle_movement()
	handle_animation()
	move_and_slide()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		double_jump = true
		
# you need to configure [jump, move_left, move_right] in:
# Project -> Project Settings -> Input Map
func handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump_sound.play()
			velocity.y = JUMP_VELOCITY
			animated_sprite_2d.animation = "jump"
		elif double_jump:
			jump_sound.play()
			velocity.y = JUMP_VELOCITY
			double_jump = false
			animated_sprite_2d.animation = "double_jump"
func handle_movement() -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = (direction == -1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_animation() -> void:
	if not is_on_floor():
		# jump animations are separated to avoid overrides
		pass
	elif abs(velocity.x) > 0.1:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"

func handle_death(delta: float) -> void:
	velocity.y += 1000 * delta
	animated_sprite_2d.animation = "death"
	move_and_slide()
