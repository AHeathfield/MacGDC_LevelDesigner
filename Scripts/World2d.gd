extends Node2D

# Happens whenever an input is pressed
func _input(event):
	if event.is_action_pressed("OpenMenu"):
		# Old way may come useful if like there's multiple levels idk tbh
		#if (self.get_child_count() > 0):
			#var level = self.get_child(0)
			#Global.SetPauseSubtree(level, !Global.game_manager.isGamePaused)
			# Global.game_manager.isGamePaused = !Global.game_manager.isGamePaused
		if (Global.game_manager.current_2d_scene != null):
			Global.game_manager.toggle_gui_visibility()
			#Maybe replace below with unpause and pause functions
			Global.SetPauseSubtree(Global.game_manager.current_2d_scene, !Global.game_manager.isGamePaused)
			Global.game_manager.isGamePaused = !Global.game_manager.isGamePaused
			
func _process(_delta: float) -> void:
	print(Global.game_manager.isGamePaused)		
