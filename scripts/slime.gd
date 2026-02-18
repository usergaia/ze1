extends CharacterBody2D

const SPEED = 20
var DIRECTION = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if ray_cast_right.is_colliding():
		DIRECTION = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		DIRECTION = 1
		animated_sprite_2d.flip_h = false
		
	position.x += (DIRECTION * SPEED) * delta
	move_and_slide()
