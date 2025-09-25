extends StaticBody2D

@export var point_a: Vector2 = Vector2.ZERO
@export var point_b: Vector2 = Vector2.ZERO
@export var speed: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = point_a
	move_to_b()

func move_to_b():
	var tween = create_tween()
	tween.tween_property(self, "global_position", point_b, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(move_to_a)
	
func move_to_a():
	var tween = create_tween()
	tween.tween_property(self, "global_position", point_a, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(move_to_b)
