extends Node2D

signal dashed(speed : float, direction : Vector2, charge : float)

@export var direction_indicator : Node2D

@export_category("Config")
@export var dash_speed : float = 400.0
@export var charge_speed : float = 15.0
@export var max_charge : float = 750.0
@export var max_indicator_length : float = 100.0
@export var dash_limit : int = 1

var current_charge : float = 0.0
var last_clicked_pos : Vector2
var current_dash_count : int = 0


func _unhandled_input(_event):
	if Input.is_action_just_pressed("charge"):
		last_clicked_pos = get_local_mouse_position()


func _physics_process(_delta):
	if Input.is_action_pressed("charge"):
		charge()
	if Input.is_action_just_released("charge") and current_charge > 0:
		dash()


func dash() -> void:
	# Check if player has dragged mouse
	var direction : Vector2 = last_clicked_pos - get_local_mouse_position()
	direction = direction.normalized()
	
	if direction and current_dash_count < dash_limit:
		current_dash_count += 1
		print(current_dash_count)
		emit_signal("dashed", dash_speed + current_charge, direction, current_charge / max_charge)
	
	# Reset charge
	current_charge = 0
	direction_indicator.updateChargeDisplay(current_charge, max_charge, last_clicked_pos)


func charge() -> void:
	# Linear charge speed for now
	current_charge += charge_speed
	# Make sure charge does not exceed the max
	current_charge = clamp(current_charge, 0.0, max_charge)
	#print("Charge: ", charge, " / ", max_charge)
	direction_indicator.updateChargeDisplay(current_charge, max_charge, last_clicked_pos)


func landed():
	current_dash_count = 0
	print(current_dash_count)
