extends Path2D

##If true, the platform will redo its path when it reaches the end.
##If false, the platform will redo it's path backwards when it reaches the end.
@export var loop := false

@export var speed_loop_on := 2.0 ##The value of the platform's speed when looping is enabled
@export var speed_loop_off := 1.0 ##The value of the platform's speed when looping is disabled

@export var collision_shape : Vector2 = Vector2(60, 16)

@onready var path: PathFollow2D = $PathFollow2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var shape = $AnimatableBody2D/CollisionShape2D.shape
@onready var sprite = $AnimatableBody2D/Sprite2D

var new_shape : RectangleShape2D = RectangleShape2D.new()

func _ready() -> void:
	if not loop:
		animation_player.play("move")
		animation_player.speed_scale = speed_loop_off
		set_process(false)
		
	#shape.set_size(Vector2(length, width))
	$AnimatableBody2D/CollisionShape2D.shape = new_shape
	$AnimatableBody2D/CollisionShape2D.shape.size = collision_shape
	sprite.scale.x = collision_shape.x/60.0
	sprite.scale.y = collision_shape.y/16.0


func _process(_delta: float) -> void:
	path.progress += speed_loop_on
	print(shape.size)
