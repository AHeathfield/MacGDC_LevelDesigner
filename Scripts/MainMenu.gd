extends CanvasLayer

var gm := Global.game_manager

func _on_new_game_pressed() -> void:
	# Deleting whatever 2D scene is loaded
	print("Restarting level")
	#gm.restart_current_2d_scene()
	gm.restart_current_level()


func _on_quit_pressed():
	print("Going back to level select")
	gm.remove_2d_scene(gm.SceneAction.DELETE)
	gm.change_gui_scene("res://Scenes/LevelSelect.tscn", gm.SceneAction.HIDE)
	gm.current_gui_scene.visible = true


func _on_continue_pressed():
	print("Continuing Level")
	gm.toggle_gui_visibility()
	# It shouldn't = null but just a safe guard
	gm.unpause_game()
	#if (gm.current_2d_scene != null):
		#Global.SetPauseSubtree(gm.current_2d_scene, false)
		#gm.isGamePaused = false
