extends Area2D

#signal goal_reached NO IDEA WHAT THIS DOES

@onready var win_menu_timer := $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Add effects here (ex confetti)
		$AudioStreamPlayer2D.play()
		win_menu_timer.start()
		Global.game_manager.pause_game()


func _on_timer_timeout() -> void:
	# ADD OPEN WIN SCREEN HERE
	var gm = Global.game_manager
	gm.change_gui_scene("res://Scenes/WinScreen.tscn", gm.SceneAction.HIDE)
	gm.current_gui_scene.visible = true
	print("player reached goal")
	
	#goal_reached.emit() someone added this idk what it does...
