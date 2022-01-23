extends "res://scenes/Pathfinding.gd"


	
func _on_Player_move():
	var Player_pos = world_to_map(Player.global_position)
	var Enemy_pos = world_to_map(Enemy.global_position)
	
	_get_path(Player_pos,Enemy_pos)
	print(path,world_to_map(Player.global_position))
	if len(path) <= 1:
		print("Died")
	else:
		Enemy.position = map_to_world(path[-2])
