class_name Collectable
extends Node2D

signal collected


func _on_area_2d_area_entered(area):
	if area.owner is Player:
		print("Collected")
		emit_signal("collected")
		queue_free()
