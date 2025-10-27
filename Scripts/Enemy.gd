extends Node2D
class_name Enemy

@export var follow_player : bool = false
@export var player : CharacterBody2D
@export var follow_speed : float = 5.0


var is_moving_right : bool
var player_in_range : bool = false
var following_positions : Array[Vector2]

# This is mainly for the move_along_path
var is_following : bool = false

func _process(delta: float) -> void:
	if follow_player:
		var temp = global_position
		if player_in_range:
			is_following = true
			following_positions.push_back(global_position)
			global_position = global_position.move_toward(player.global_position, follow_speed * delta)
			# Setting direction
		elif not following_positions.is_empty():
			global_position = global_position.move_toward(following_positions.pop_back(), follow_speed * delta)
		else:
			is_following = false
		# Setting movement direction
		if global_position.x - temp.x < 0:
			is_moving_right = false
		elif global_position.x - temp.x > 0:
			is_moving_right = true
