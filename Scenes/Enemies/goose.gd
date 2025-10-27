extends Enemy

@export var raycast_length : float = 50

@onready var raycast : RayCast2D = $RayCast2D

func _ready() -> void:
	raycast.target_position.x = raycast_length


func _process(delta: float) -> void:
	super(delta)
	# Flips sprite to face direction it moves
	if is_moving_right:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	# If player in range switch to angry sprite
	if player_in_range:
		$AnimatedSprite2D.animation = "angry"
	else:
		$AnimatedSprite2D.animation = "default"
	
	# Rotates the raycast towards player
	raycast.look_at(player.global_position)
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
