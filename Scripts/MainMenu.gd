extends CanvasLayer

var gm := Global.game_manager

func _on_new_game_pressed() -> void:
	# Deleting whatever 2D scene is loaded
	print("Starting new game")
	gm.restart_current_2d_scene()
	#gm.change_2d_scene("res://Scenes/Levels/TestLevel.tscn", gm.SceneAction.DELETE)
	
	# Hiding the GUI
	gm.current_gui_scene.visible = false


func _on_quit_pressed():
	print("Going back to level select")
	gm.remove_2d_scene(gm.SceneAction.DELETE)
	gm.change_gui_scene("res://Scenes/LevelSelect.tscn", gm.SceneAction.HIDE)
	gm.current_gui_scene.visible = true
