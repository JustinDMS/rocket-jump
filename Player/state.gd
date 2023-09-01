class_name State
extends Node

var player : Player

func stateEnter() -> void:
	pass


func stateExit() -> void:
	pass


func stateInput(_event: InputEvent) -> State:
	return null


func stateProcess(_delta) -> State:
	return null


func statePhysicsProcess(_delta) -> State:
	return null


func getGravity() -> float:
	if player.velocity.y < 0: 
		return player.jump_gravity
	else: 
		return player.fall_gravity


func applyGravity(delta) -> void:
	player.velocity.y += getGravity() * delta


func getInputDirection() -> float:
	var x : float = 0.0
	
	if Input.is_action_pressed("move_left"):
		x -= 1.0
	if Input.is_action_pressed("move_right"):
		x += 1.0
	
	return x


func jump() -> void:
	player.velocity.y = player.jump_velocity
