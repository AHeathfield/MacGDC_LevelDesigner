extends LevelInterface

@onready var slime := $Enemies/Slime

@export var reg_volume : float = -6
@export var low_volume : float = -12

var slime_start_pos : Vector2
var isPaused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	slime_start_pos = slime.position
	# This is just for convienence
	$Intro.volume_db = reg_volume
	$Loop.volume_db = reg_volume
	$Intro.play()

# If escape pressed lower music volume
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("OpenMenu"):
		isPaused = true
		$Intro.volume_db = low_volume
		$Loop.volume_db = low_volume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	# When the game is paused this method won't run
	# So if this runs that means it is unpaused
	if isPaused:
		isPaused = false
		$Intro.volume_db = reg_volume
		$Loop.volume_db = reg_volume
		


# Note the restart handles restarting the player position
# already!
func restart() -> void:
	super()
	# Can add other resets here!
	slime.position = slime_start_pos
	$Time.current_time = 0


func _on_intro_finished() -> void:
	$Loop.play()
