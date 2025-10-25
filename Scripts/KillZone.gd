extends Area2D

var gm := Global.game_manager

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("You Died!")
		# Can add like a timer and stuff to run death effects or something
		gm.restart_current_level()
