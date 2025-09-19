extends Area2D

signal goal_reached


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player reached goal")
		goal_reached.emit()
