extends Node

var current_collectables : int = 0


func _on_collectable_collected():
	current_collectables += 1
	print(current_collectables)
