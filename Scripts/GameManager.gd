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
var removedNodes := {}
var hiddenNodes := {}

var isGamePaused := false


func _ready() -> void:
	# In Project Settings->Global is where Global is defined
	Global.game_manager = self
	current_gui_scene = $GUI/LevelSelect

	#current_gui_scene = $GUI/CanvasLayer/MainMenu # CanvasLayer means always on screen even if there is a camera


func toggle_gui_visibility() -> void:
	current_gui_scene.visible = !current_gui_scene.visible


func remove_gui_scene(scene_action: SceneAction) -> void:
	if current_gui_scene != null:
		match scene_action:
			SceneAction.DELETE:
				current_gui_scene.queue_free()
			SceneAction.HIDE:
				current_gui_scene.visible = false
				hiddenNodes[current_gui_scene.scene_file_path] = current_gui_scene
			SceneAction.REMOVE:
				gui.remove_child(current_gui_scene)
				removedNodes[current_gui_scene.scene_file_path] = current_gui_scene


# Right now I only suspect 1 scene at a time, can easily change it by making current_gui_scene just like var new
func add_gui_scene(scene_path: String):
	if (hiddenNodes.has(scene_path)):
		current_gui_scene = hiddenNodes[scene_path]
		hiddenNodes.erase(scene_path)
		# We still may want that node to be hidden
	elif (removedNodes.has(scene_path)):
		current_gui_scene = removedNodes[scene_path]
		removedNodes.erase(scene_path)
	else:
		current_gui_scene = load(scene_path).instantiate()
		gui.add_child(current_gui_scene)


# Shortcut method pre much
func change_gui_scene(scene_path: String, scene_action: SceneAction) -> void:
	remove_gui_scene(scene_action)
	add_gui_scene(scene_path)


func remove_2d_scene(scene_action: SceneAction):
	isGamePaused = false # In case game was paused
	if current_2d_scene != null:
		match scene_action:
			SceneAction.DELETE:
				current_2d_scene.queue_free()
			SceneAction.HIDE:
				current_2d_scene.visible = false
				hiddenNodes[current_2d_scene.scene_file_path] = current_2d_scene
			SceneAction.REMOVE:
				world_2d.remove_child(current_2d_scene)
				removedNodes[current_2d_scene.scene_file_path] = current_2d_scene


func add_2d_scene(scene_path: String):
	if (hiddenNodes.has(scene_path)):
		current_2d_scene = hiddenNodes[scene_path]
		hiddenNodes.erase(scene_path)
		# We still may want that node to be hidden
	elif (removedNodes.has(scene_path)):
		current_2d_scene = removedNodes[scene_path]
		removedNodes.erase(scene_path)
	else:
		current_2d_scene = load(scene_path).instantiate()
		world_2d.add_child(current_2d_scene)


func change_2d_scene(scene_path: String, scene_action: SceneAction) -> void:
	remove_2d_scene(scene_action)
	add_2d_scene(scene_path)


func restart_current_2d_scene():
	if (current_2d_scene != null):
		change_2d_scene(current_2d_scene.scene_file_path, SceneAction.DELETE)
		# Or easy solution is delete scene and just load it again but if its big it will have a long loading screen
