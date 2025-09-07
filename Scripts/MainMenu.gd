extends CenterContainer

func _on_new_game_pressed() -> void:
	# Deleting whatever 2D scene is loaded
	var gm = Global.game_manager
	gm.change_2d_scene("res://Scenes/TestLevel.tscn", gm.SceneAction.DELETE)
	
	# Hiding the GUI
	gm.current_gui_scene.visible = false
