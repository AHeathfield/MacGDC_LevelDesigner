extends CenterContainer

@export var levels : Array[PackedScene]
# This will be an array of all the level names, we have to manually add them to this array but that's ok, it's not like we have 100+ levels...
# If there is A LOT OF LEVELS we will automate this :)
#var levelNames: Array[String] = [
	#"TestLevel",
	#"TestLevel 2",
	#"Level Template",
	#"Aidan"
#]


func _ready() -> void:
	# Creates all the buttons to access the specific levels
	var vBox = $PanelContainer/ScrollContainer/VBoxContainer
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
