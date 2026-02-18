extends Area2D
func _on_body_entered(body: Node2D) -> void:
	body.coins_collected += 1
	print("Coins:", body.coins_collected)
	queue_free()
