extends Area2D

signal goal_reached

@onready var win_menu_timer := $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Add effects here (ex confetti)
		win_menu_timer.start()
		Global.game_manager.pause_game()


func _on_timer_timeout() -> void:
	# ADD OPEN WIN SCREEN HERE
	print("player reached goal")
	var gm = Global.game_manager
	gm.remove_2d_scene(gm.SceneAction.DELETE)
	gm.change_gui_scene("res://Scenes/LevelSelect.tscn", gm.SceneAction.HIDE)
	gm.current_gui_scene.visible = true
	goal_reached.emit()
