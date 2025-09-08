# Will contain functions to load and unload scenes manually
class_name GameManager extends Node
enum SceneAction
{
	DELETE = 0,
	HIDE = 1,
	REMOVE = 2
}

@export var world_2d : Node2D
@export var gui : Control

var current_2d_scene
var current_gui_scene
var isGamePaused := false


func _ready() -> void:
	# In Project Settings->Global is where Global is defined
	Global.game_manager = self
	current_gui_scene = $GUI/CanvasLayer/MainMenu # CanvasLayer means always on screen even if there is a camera


func toggle_gui_visibility() -> void:
	if (current_gui_scene.visible):
		current_gui_scene.visible = false
	else:
		current_gui_scene.visible = true


func change_gui_scene(new_scene: String, scene_action: SceneAction) -> void:
	if current_gui_scene != null:
		match scene_action:
			SceneAction.DELETE:
				current_gui_scene.queue_free()
			SceneAction.HIDE:
				current_gui_scene.visible = false
			SceneAction.REMOVE:
				gui.remove_child(current_gui_scene)
	var new = load(new_scene).instantiate()
	gui.add_child(new)
	current_gui_scene = new


func change_2d_scene(new_scene: String, scene_action: SceneAction) -> void:
	isGamePaused = false # In case game was paused
	if current_2d_scene != null:
		match scene_action:
			SceneAction.DELETE:
				current_2d_scene.queue_free()
			SceneAction.HIDE:
				current_2d_scene.visible = false
			SceneAction.REMOVE:
				world_2d.remove_child(current_2d_scene)
	var new = load(new_scene).instantiate()
	world_2d.add_child(new)
	current_2d_scene = new
