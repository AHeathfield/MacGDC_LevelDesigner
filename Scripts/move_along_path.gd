extends PathFollow2D

# By default PathFollow2D loops back to start point
@export var goose : Node2D

var speed : float
var ping_pong : bool
var direction : int = 1
var is_moving : bool = true

func _process(delta: float) -> void:
	var pos_before = position
	if not goose.is_following:
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
		progress += direction * delta * speed * 50
	
	# Setting the goose's facing direction
	if position.x - pos_before.x < 0:
		goose.is_moving_right = false
	elif position.x - pos_before.x > 0:
		goose.is_moving_right = true
