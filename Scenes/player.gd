extends CharacterBody2D


const SPEED := 300.0
const JUMP_VELOCITY := -400.0
const AIR_JUMP_VELOCITY := -300.0
const GRAVITY := 980
const GLIDE_GRAVITY := 200

var max_jumps := 3
var jumps_done = 0
var was_on_floor := false
var is_gliding := false

func _physics_process(delta: float) -> void:
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
	
	# Handle jumps
	if Input.is_action_just_pressed("Jump"):
		if jumps_done < max_jumps:
			if jumps_done == 0:
				velocity.y = JUMP_VELOCITY
			else:
				velocity.y = AIR_JUMP_VELOCITY
			jumps_done += 1
		print("Jumps left: ", max_jumps - jumps_done)
		
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


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
