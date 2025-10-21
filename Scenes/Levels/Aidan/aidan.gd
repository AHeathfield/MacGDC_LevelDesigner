extends LevelInterface

@onready var slime := $Slime
var slime_start_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	slime_start_pos = slime.position



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)


# Note the restart handles restarting the player position
# already!
func restart() -> void:
	super()
	# Can add other resets here!
	slime.position = slime_start_pos
	
