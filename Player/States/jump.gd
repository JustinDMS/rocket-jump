extends State

@export var air_state : State


func stateEnter() -> void:
	jump()


func stateExit() -> void:
	pass


func stateInput(_event: InputEvent) -> State:
	return null


func stateProcess(_delta) -> State:
	return null


func statePhysicsProcess(_delta) -> State:
	applyGravity(_delta)
	return air_state
