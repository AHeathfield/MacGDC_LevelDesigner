extends PathFollow2D

# By default PathFollow2D loops back to start point
@export var speed : float = 1.0
@export var ping_pong : bool = true
@export var enemy : Enemy

var direction : int = 1
var is_moving : bool = true

func _process(delta: float) -> void:
	var pos_before = position
	if not enemy.is_following:
		if ping_pong:
			if loop:
				var next_progress_ratio = progress_ratio + direction * delta * speed / 10
				if next_progress_ratio <= 0:
					direction = 1
					progress_ratio = 0
				elif next_progress_ratio >= 1:
					direction = -1
					progress_ratio = 1
		# Moving along path
		progress_ratio += direction * delta * speed / 10
	
	# Setting the enemy's facing direction
	if position.x - pos_before.x < 0:
		enemy.is_moving_right = false
	elif position.x - pos_before.x > 0:
		enemy.is_moving_right = true
