extends Node2D

@export_group("Follow Variables")
## Add player if you want goose to follow the player.
@export var follow_player : CharacterBody2D
## This is the speed of the goose when following the player.
@export var follow_speed : float = 100
## This defines the max distance the goose will be able to see the player.
@export var goose_range : float = 100

@export_group("Path Variables")
## This is how fast the goose follows it's path.
@export var path_speed : float = 5.0
## If true, when goose reaches end of path it will reverse it's path back to the start and then continue this back and forth loop.
@export var ping_pong : bool = true
## If true, once the goose reaches the end of its path it will just stop there.
@export var one_shot : bool = false


@onready var pathfollow : PathFollow2D = $PathFollow2D
@onready var raycast : RayCast2D = $PathFollow2D/goose/RayCast2D
@onready var sprite : AnimatedSprite2D = $PathFollow2D/goose/AnimatedSprite2D
@onready var goose : Node2D = $PathFollow2D/goose

var is_moving_right : bool
var player_in_range : bool = false
var following_positions : Array[Vector2]

# This is mainly for the move_along_path
var is_following : bool = false


func _ready() -> void:
	raycast.target_position.x = goose_range
	pathfollow.loop = not one_shot
	pathfollow.speed = path_speed
	pathfollow.ping_pong = ping_pong


func _process(delta: float) -> void:
	# Follow player in range
	if follow_player != null:
		var temp = goose.global_position
		if player_in_range:
			is_following = true
			following_positions.push_back(goose.global_position)
			goose.global_position = goose.global_position.move_toward(follow_player.global_position, follow_speed * delta)
			# Setting direction
		elif not following_positions.is_empty():
			goose.global_position = goose.global_position.move_toward(following_positions.pop_back(), follow_speed * delta)
		else:
			is_following = false
		# Setting movement direction
		if goose.global_position.x - temp.x < 0:
			is_moving_right = false
		elif goose.global_position.x - temp.x > 0:
			is_moving_right = true
	
	# Flips sprite to face direction it moves
	if is_moving_right:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
	# If player in range switch to angry sprite
	if player_in_range:
		sprite.animation = "angry"
	else:
		sprite.animation = "default"
	
	if follow_player != null:
		# Rotates the raycast towards player
		raycast.look_at(follow_player.global_position)
		# Raycasts happen on physic frames this forces it to happen on this frame
		raycast.force_raycast_update()
		
		#if not raycast.enabled:
			#raycast.enabled = true
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider is CharacterBody2D:
				if collider.is_in_group("Player"):
					player_in_range = true
			else:
				player_in_range = false
		else:
			player_in_range = false
