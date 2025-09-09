extends Node2D

# Happens whenever an input is pressed
func _input(event):
	# One future problem may be that this assumes that the first child is the level
	if event.is_action_pressed("OpenMenu"):
		Global.game_manager.toggle_gui_visibility()
		if (self.get_child_count() > 0):
			var level = self.get_child(0)
			Global.SetPauseSubtree(level, !Global.game_manager.isGamePaused)
			Global.game_manager.isGamePaused = !Global.game_manager.isGamePaused
