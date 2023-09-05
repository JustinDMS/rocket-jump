extends State

@export var idle_state : State
@export var jump_state : State
@export var air_state : State


func stateEnter() -> void:
	pass


func stateExit() -> void:
	pass


func stateInput(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	return null


func stateProcess(_delta) -> State:
	return null


func statePhysicsProcess(_delta) -> State:
	var input : float = getInputDirection()
	if input:
		player.velocity.x = input * player.move_speed
	else:
		player.velocity.x = lerpf(player.velocity.x, 0.0, 0.5)
	
	applyGravity(_delta)
	
	# If not moving
	if player.is_on_floor():
		if player.velocity.x == 0:
			return idle_state
	else:
		return air_state
	
	return null
