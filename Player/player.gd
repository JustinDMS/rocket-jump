class_name Player
extends CharacterBody2D

@export var state_machine : StateMachine

@export_category("Moving")
@export var move_speed : float = 400.0
@export var max_speed_x : float = 1250.0
@export var max_speed_y : float = 2500.0
@export var jump_height : float = 100.0
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.4

@export_category("Effects")
@export var blast : PackedScene

@onready var jump_velocity : float = -((2.0 * jump_height) / jump_time_to_peak)
@onready var jump_gravity : float = -((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak))
@onready var fall_gravity : float = -((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))
@onready var line_2d = $Line2D


func _ready():
	state_machine.enter()


func _unhandled_input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	state_machine.playerInput(_event)


func _physics_process(delta):
	state_machine.playerPhysicsProcess(delta)
	move_and_slide()


func dash(speed, direction):
	
	# Check if dashing in opposite direction
	if sign(velocity.x) != sign(direction.x):
		velocity.x = 0
	
	# Check if player is 
	if direction.y < 0:
		velocity.y = 0
	
	velocity += direction * speed
	velocity.x = clampf(velocity.x, -max_speed_x, max_speed_x)
	velocity.y = clampf(velocity.y, -max_speed_y, max_speed_y)
	emitBlastParticle(direction)


func emitBlastParticle(direction : Vector2) -> void:
	var new_blast : GPUParticles2D = blast.instantiate()
	get_parent().add_child(new_blast)
	new_blast.global_position = global_position
	new_blast.look_at(global_position - direction)
	new_blast.emitting = true
