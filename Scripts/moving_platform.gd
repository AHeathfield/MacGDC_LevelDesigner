extends Path2D

##If true, the platform will redo its path when it reaches the end.
##If false, the platform will redo it's path backwards when it reaches the end.
@export var loop := false

@export var speed_loop_on := 2.0 ##The value of the platform's speed when looping is enabled
@export var speed_loop_off := 1.0 ##The value of the platform's speed when looping is disabled

@onready var path: PathFollow2D = $PathFollow2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if not loop:
		animation_player.play("move")
		animation_player.speed_scale = speed_loop_off
		set_process(false)

func _process(_delta: float) -> void:
	path.progress += speed_loop_on
