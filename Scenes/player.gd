extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var MAX_FALL_SPEED = 500

# Wall stuff
@export var WALL_FALL_SPEED = 100
@export var WALL_JUMP_X_SPEED = 500
var directionAwayFromWall = 0
var isWallSliding := false
var isWallJumping := false

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED 

	# for when they get on wall initially
	if is_on_wall() and direction and velocity.y > 0:
		isWallSliding = true
		directionAwayFromWall = direction * -1
	elif not isWallJumping:
		if not is_on_wall():
			isWallSliding = false
			directionAwayFromWall = 0
		if is_on_floor():
			isWallSliding = false
			directionAwayFromWall = 0

	# Handling Inputs
	if not isWallJumping:
		HandleDirectionalMovement(direction)
	else:
		HandleWallJumpBuffer()
	
	HandleWallSlide()
	HandleJump()
	
	move_and_slide()


func HandleJump() -> void:
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif isWallSliding:
			velocity.y = JUMP_VELOCITY
			velocity.x = directionAwayFromWall * WALL_JUMP_X_SPEED
			isWallSliding = false
			
			# This handles jump buffer to achieve a smooth wall jump
			isWallJumping = true
			$WallJumpTimer.start()

func HandleDirectionalMovement(direction) -> void:
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

func HandleWallSlide() -> void:
	if isWallSliding:
		velocity.y = WALL_FALL_SPEED

func HandleWallJumpBuffer() -> void:
	velocity.x = directionAwayFromWall * SPEED

func _on_wall_jump_timer_timeout() -> void:
	isWallJumping = false
	directionAwayFromWall = 0
