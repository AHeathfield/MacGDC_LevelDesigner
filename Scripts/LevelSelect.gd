extends Control

@export var levels : Array[PackedScene]

func _ready() -> void:
	# Creates all the buttons to access the specific levels
	var vBox = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer
	var levelButtonScene = preload("res://Scenes/LevelButton.tscn")
	#for level in levelNames:
	for level in levels:
		# Instantiating Level (for not adding it to world thats done when you click button)
		var level_inst = level.instantiate() as LevelInterface
		
		# Creating level Button
		var newButton = levelButtonScene.instantiate()
		newButton.level = level_inst
		newButton.text = level_inst.level_name
		
		vBox.add_child(newButton)
		newButton.more_info.text = level_inst.level_name + "\nCreated By: " + level_inst.creator_name


func _on_quit_pressed() -> void:
	get_tree().quit()
