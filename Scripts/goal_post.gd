extends Area2D

signal goal_reached


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player reached goal")
		var gm = Global.game_manager
		gm.remove_2d_scene(gm.SceneAction.DELETE)
		gm.change_gui_scene("res://Scenes/LevelSelect.tscn", gm.SceneAction.HIDE)
		gm.current_gui_scene.visible = true
		goal_reached.emit()
