extends State

signal landed

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
		player.velocity.x = lerpf(player.velocity.x, input * player.move_speed, 0.1)
	
	if player.is_on_floor():
		emit_signal("landed")
		return ground_state
	
	return null
