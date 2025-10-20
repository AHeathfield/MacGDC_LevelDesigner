extends Button

var level : LevelInterface

func _on_pressed():
	#var levelPath = "res://Scenes/Levels/" + self.text + ".tscn"
	var gm = Global.game_manager
	if (FileAccess.file_exists(level.scene_file_path)):
		gm.change_2d_scene(level.scene_file_path, gm.SceneAction.DELETE)
		gm.change_gui_scene("res://Scenes/MainMenu.tscn", gm.SceneAction.HIDE)
		gm.current_gui_scene.visible = false
	else:
		printerr("Cannot find level scene at: " + level.scene_file_path + "\nMake sure the scene name is the same as the level name.")
	
	# Hiding the GUI
	#gm.current_gui_scene.visible = false
