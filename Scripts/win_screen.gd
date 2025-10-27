extends CanvasLayer

var gm = Global.game_manager

func _ready() -> void:
	# I made 2D scene always LevelInterface
	var level = gm.current_2d_scene
	$PanelContainer/MarginContainer/VBoxContainer/Time.text = level.time_display
	$PanelContainer/MarginContainer/VBoxContainer/LevelName.text = level.level_name
	$PanelContainer/MarginContainer/VBoxContainer/LevelCreator.text += level.creator_name
	

func _on_play_again_pressed() -> void:
	gm.restart_current_level()
	gm.change_gui_scene("res://Scenes/PauseScreen.tscn", gm.SceneAction.DELETE)

func _on_levels_pressed() -> void:
	gm.remove_2d_scene(gm.SceneAction.DELETE)
	gm.change_gui_scene("res://Scenes/LevelSelect.tscn", gm.SceneAction.DELETE)
	gm.current_gui_scene.visible = true
