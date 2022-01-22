extends "res://scenes/Pathfinding.gd"

func _on_Player_move():
	var Player_pos = world_to_map(get_node("Player").global_position)
	var Enemy_pos = world_to_map(get_node("Enemy").global_position)
	
	_get_path(Player_pos,Enemy_pos)
	print(path,world_to_map(get_node("Player").global_position))
	if len(path) <= 1:
		print("Died")
	else:
		get_node("Enemy").position = map_to_world(path[-2])
