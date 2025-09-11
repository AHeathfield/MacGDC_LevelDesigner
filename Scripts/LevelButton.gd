extends Button

func _on_pressed():
	var levelPath = "res://Scenes/Levels/" + self.text + ".tscn"
	var gm = Global.game_manager
	if (FileAccess.file_exists(levelPath)):
		gm.change_2d_scene(levelPath, gm.SceneAction.DELETE)
		gm.change_gui_scene("res://Scenes/MainMenu.tscn", gm.SceneAction.HIDE)
		gm.current_gui_scene.visible = false
	
	# Hiding the GUI
	#gm.current_gui_scene.visible = false
