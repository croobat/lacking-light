extends TileMap
class_name AStar_Path

onready var astar = AStar2D.new()
onready var used_cells = get_used_cells_by_id(1)

onready var Enemy = get_parent().get_node("Enemy")
onready var Player = get_parent().get_node("Player")
var path = []

func _ready():
	_add_points()
	_connect_points()

func _add_points():
	for cell in used_cells:
		astar.add_point(id(cell),cell,1.0)

func _connect_points():
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
		
