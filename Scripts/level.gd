extends Node
class_name LevelInterface

# VARIABLES
@export_group("Level Info")

## The name of your level (displayed in level select).
@export var level_name : String

## You!
@export var creator_name : String

@onready var player = $Player
@onready var tilemaplayer = $Mainground
@onready var timer = $Time

var start_pos: Vector2
var time_display : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = player.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile_coords = tilemaplayer.local_to_map(player.global_position)
	var data = tilemaplayer.get_cell_tile_data(tile_coords)
	#print(data.get_custom_data("Hazard"))
	if data and data.get_custom_data("Hazard"):
		restart()
		print("player died")
	
	#Updating the timer
	timer.current_time += delta
	timer.label.text = timer.convert_time_to_string(timer.current_time)
	time_display = timer.label.text


# Resetting the player position I think should be a must, but creators will have the option to add more
func restart() -> void:
	player.global_position = start_pos
	player.velocity = Vector2.ZERO
	timer.current_time = 0.0
