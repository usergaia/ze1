extends Area2D

@onready var timer: Timer = $Timer
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

func _on_body_entered(body: Node2D) -> void:
	death_sound.play()
	Engine.time_scale = 0.7
	body.get_node("AnimatedSprite2D").animation = "death"
	body.is_dead = true
	timer.start()
	
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
