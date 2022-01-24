extends Area2D
class_name AStar_Path

onready var astar = AStar2D.new()
onready var Player = get_parent().get_parent().get_node("Player")
onready var map = get_parent().get_parent().get_node("WorldGenerator")
var path = []

func _add_points(used_cells):
	for cell in used_cells:
		astar.add_point(id(cell),cell,1.0)

func _connect_points(used_cells):
	for cell in used_cells:
		var neighbors = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]
		for neighbor in neighbors:
			var next_cell = cell + neighbor
			if used_cells.has(next_cell):
				astar.connect_points(id(cell),id(next_cell),false)

func _get_path(start,end):
	path = astar.get_point_path(id(start),id(end))
	
func id(point):
	var a = point.x
	var b = point.y
	return (a+b) * (a+b+1)/2+b		
		
func _on_Player_move():
	var used_cells = map.get_used_cells_by_id(1)
	_add_points(used_cells)
	_connect_points(used_cells)
	var Player_pos = map.world_to_map(Player.global_position)
	var Enemy_pos = map.world_to_map(self.global_position)
	_get_path(Player_pos,Enemy_pos)
	#(path,world_to_map(Player.global_position))
	if len(path) <= 1:
		pass
	else:
		self.position = map.map_to_world(path[-2])

