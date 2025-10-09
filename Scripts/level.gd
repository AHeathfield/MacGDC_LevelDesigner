extends Node
class_name LevelInterface

@onready var player = $Player
@onready var tilemaplayer = $Mainground

var start_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = player.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile_coords = tilemaplayer.local_to_map(player.global_position)
	var data = tilemaplayer.get_cell_tile_data(tile_coords)
	#print(data.get_custom_data("Hazard"))
	if data and data.get_custom_data("Hazard"):
		player.position = start_pos
