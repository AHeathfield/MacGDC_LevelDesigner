# This is an example script that your root node of the level
# must have. It must extend LevelInterface and you must include
# these methods with the super() calls. I would just copy and
# paste this into your own script and then work from there.
# Other than that your free to do whatever you want goodluck :)
extends LevelInterface


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)


# Note the restart handles restarting the player position
# already!
func restart() -> void:
	super()
	$Time.current_time = 0
	# Can add other resets here!
