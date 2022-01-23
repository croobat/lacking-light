extends Area2D


func _ready():
	pass
func _physics_process(delta):
	pass
"""
func _on_Player_move():
	var line = get_path_algorithm(self.position,get_parent().get_node("Player").position)
	self.position.x = line[1][0]
	self.position.y = line[1][1]
	

func get_path_algorithm(start_coord,end_coord):
	var x1 = start_coord[0]
	var y1 = start_coord[1]
	var x2 = end_coord[0]
	var y2 = end_coord[1]
	var dx = x2 - x1
	var dy = y2 - y1
	
	var is_steep = abs(dy) > abs(dx)
	var tmp = 0

	if is_steep:
		tmp = x1
		x1 = y1
		y1 = tmp
		tmp = x2
		x2 = y2
		y2 = tmp
	
	var swapped = false
	
	if x1 > x2:
		tmp = x1
		x1 = x2
		x2 = tmp
		tmp = y1
		y1 = y2
		y2 = tmp
		swapped = true
		
	dx = x2 - x1
	dy = y2 - y1
	
	# Calculate error
	var error = int(dx / 2.0)
	var ystep = 8 if y1 < y2 else -1

	# Iterate over bounding box generating points between start and end
	var y = y1
	var points = []
	for x in range(x1, x2 + 1,8):
		var coord = [y, x] if is_steep else [x, y]
		points.append(coord)
		error -= abs(dy)
		if error < 0:
			y += ystep
			error += dx
	if swapped:
		points.invert()
	
	return points
"""
