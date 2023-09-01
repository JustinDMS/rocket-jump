extends State

@export var ground_state : State


func stateEnter() -> void:
	pass


func stateExit() -> void:
	pass


func stateInput(_event: InputEvent) -> State:
	return null


func stateProcess(_delta) -> State:
	return null


func statePhysicsProcess(_delta) -> State:
	applyGravity(_delta)
	var input : float = getInputDirection()
	if input:
		player.velocity.x = lerpf(player.velocity.x, ease(player.velocity.x, 3), 0.005)
	
	if player.is_on_floor():
		return ground_state
	
	return null