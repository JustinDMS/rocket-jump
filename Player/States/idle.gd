extends State

@export var ground_state : State
@export var jump_state : State
@export var air_state : State


func stateEnter() -> void:
	pass


func stateExit() -> void:
	pass


func stateInput(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed("move_right") and player.is_on_floor():
		return ground_state
	if Input.is_action_just_pressed("move_left") and player.is_on_floor():
		return ground_state
	return null


func stateProcess(_delta) -> State:
	return null


func statePhysicsProcess(_delta) -> State:
	applyGravity(_delta)
	if not player.is_on_floor():
		return air_state
	return null
