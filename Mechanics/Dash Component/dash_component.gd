extends Node2D

signal dashed(speed : float, direction : Vector2)

@export var direction_indicator : Node2D

@export_category("Config")
@export var dash_speed : float = 500.0
@export var charge_speed : float = 10.0
@export var max_charge : float = 500.0
@export var max_indicator_length : float = 100.0

var current_charge : float = 0.0
var last_clicked_pos : Vector2


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
	
	if direction:
		emit_signal("dashed", dash_speed + current_charge, direction)
	
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
