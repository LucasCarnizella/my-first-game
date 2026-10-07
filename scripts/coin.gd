extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	# Vanish when collected
	queue_free()
