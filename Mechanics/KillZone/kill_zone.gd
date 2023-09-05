extends Area2D


func killZoneTouched(area):
	print("Dead")
	get_tree().reload_current_scene()
