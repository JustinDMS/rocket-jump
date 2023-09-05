extends Line2D

@export_category("Config")
@export var max_indicator_length : float = 125.0


func updateChargeDisplay(current_charge : float, max_charge : float, last_clicked_pos : Vector2) -> void:
	var point_count = get_point_count()
	
	# If no charge
	if current_charge < 1:
		#print("Point count: ", point_count)
		for i in range(point_count):
			#print("Setting point: ", i)
			set_point_position(i, Vector2.ZERO)
		return
	
	var direction : Vector2 = last_clicked_pos - get_local_mouse_position()
	direction = direction.normalized()
	var ratio : float = (current_charge / max_charge) * max_indicator_length
	set_point_position(2, direction * ratio)
	
	setColor(current_charge, max_charge)


func setColor(current_charge : float, max_charge : float) -> void:
	#print(gradient.colors[1])
	#print(current_charge / max_charge)
	var progress : float = current_charge / max_charge
	if progress == 1:
		print("Done")
		gradient.colors = [Color.GREEN.lerp(Color.RED, 0.15), Color.RED]
		return
	gradient.colors = [Color.GREEN, Color.GREEN.lerp(Color.RED, progress)]
