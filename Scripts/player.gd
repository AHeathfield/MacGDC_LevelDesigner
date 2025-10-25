extends CharacterBody2D

const SPEED := 300.0
const SPRINT_SPEED := 500.0
const JUMP_VELOCITY := -400.0
const AIR_JUMP_VELOCITY := -300.0
const GRAVITY := 980
const GLIDE_GRAVITY := 200

var max_jumps := 3
var jumps_done = 0
var was_on_floor := false
var is_gliding := false

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
		if is_gliding: velocity.y += GLIDE_GRAVITY * delta
		else: velocity += get_gravity() * delta
		if was_on_floor:
			jumps_done = 1
	else: 
		jumps_done = 0
		is_gliding = false
		
	was_on_floor = is_on_floor()

	# for when they get on wall initially
	if is_on_wall() and direction and velocity.y > 0:
		isWallSliding = true
		jumps_done = 0
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
	
	if Input.is_action_pressed("Jump") and velocity.y >= 0:
		is_gliding = true
	
	if is_gliding: print("Player is gliding")
	
	# Variable jump height if the player holds jump button
	if Input.is_action_just_released("Jump"):
		is_gliding = false
		if velocity.y < 0:
			@warning_ignore("integer_division")
			if jumps_done == 0:
				velocity.y = JUMP_VELOCITY / 4
			else:
				velocity.y = AIR_JUMP_VELOCITY / 4
	
	move_and_slide()


# HELPER FUNCTIONS
func HandleJump() -> void:
	if Input.is_action_just_pressed("Jump"):
		if jumps_done < max_jumps:
			$JumpSFX.play()
			if isWallSliding:
				jumps_done = 0
				velocity.x = directionAwayFromWall * WALL_JUMP_X_SPEED
				isWallSliding = false
				# This handles jump buffer to achieve a smooth wall jump
				isWallJumping = true
				$WallJumpTimer.start()

			if jumps_done == 0:
				velocity.y = JUMP_VELOCITY
			else:
				velocity.y = AIR_JUMP_VELOCITY
			jumps_done += 1
		print("Jumps left: ", max_jumps - jumps_done)


func HandleDirectionalMovement(direction) -> void:
	if direction:
		if Input.is_action_pressed("Sprint"):
			velocity.x = direction * SPRINT_SPEED
		else:
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
