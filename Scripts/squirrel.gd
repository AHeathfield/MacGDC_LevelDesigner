extends Node2D

const SPEED = 60

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		var body = ray_cast_right.get_collider()
		if body != null:
			if not body.is_in_group("Player"):
				direction = -1
				animated_sprite_2d.flip_h = true
				if ray_cast_down.position.x > 0:
					ray_cast_down.position.x *= -1
		
	if ray_cast_left.is_colliding():
		var body = ray_cast_left.get_collider()
		if body != null:
			if not body.is_in_group("Player"):
				direction = 1
				animated_sprite_2d.flip_h = false
				if ray_cast_down.position.x < 0:
					ray_cast_down.position.x = abs(ray_cast_down.position.x)
			
	if not ray_cast_down.is_colliding():
		direction *= -1
		animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h
		ray_cast_down.position.x *= -1
	
	position.x += direction * SPEED * delta
