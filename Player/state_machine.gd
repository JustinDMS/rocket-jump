class_name StateMachine
extends Node

@export var player : Player
@export var states : Array[State]
@export var starting_state : State

var current_state : State


func enter():
	for state in states:
		state.player = player
	changeState(starting_state)


func changeState(new_state : State) -> void:
	if current_state:
		current_state.stateExit()
	
	current_state = new_state
	print(current_state.name)
	current_state.stateEnter()


func playerInput(event : InputEvent) -> void:
	var new_state : State = current_state.stateInput(event)
	if new_state:
		changeState(new_state)


func playerProcess(delta) -> void:
	var new_state : State = current_state.stateProcess(delta)
	if new_state:
		changeState(new_state)


func playerPhysicsProcess(delta) -> void:
	var new_state : State = current_state.statePhysicsProcess(delta)
	if new_state:
		changeState(new_state)
