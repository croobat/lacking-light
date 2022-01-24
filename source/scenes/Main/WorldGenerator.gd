extends TileMap

const START_ROOM_COUNT = 2
const ROOM_INCREASE_PER_LEVEL = 2
const TOTAL_ROOMS_AVAILABLE = 8
const CELL_SIZE = 8
const ROOMS_SIZE = 10
const EXTERNAL_LIMIT_GRID = 5
var world_size = 13
var roomDict = {}
var world = []
var posible_rooms = []
var occupied_rooms = []
signal world_generated
onready var map = []
onready var new_items = []

func _ready():
	randomize()
	var level = Data.player["Level"]
	Data.player["Oil"] = 8
	world_size += level
	var total_rooms = START_ROOM_COUNT + level * ROOM_INCREASE_PER_LEVEL
	#loading room templates
	for room_num in (TOTAL_ROOMS_AVAILABLE):
		roomDict[room_num] = load("res://scenes/Maps/room" + str(room_num) + ".tscn")
	
	#generate world grid
		#0 means empty, 1 means spawnable, 2 means occupied, 3 means block
	for i in world_size:
		world.append([])
		world[i].resize(world_size)
		for j in world_size:
			world[i][j] = 0
	#occupy center tile
	world[world_size/2 | 0][world_size/2 | 0] = 2
	Data.player["playerPos"] = Vector2(((world_size/2 | 0)+0.5)*ROOMS_SIZE*CELL_SIZE, ((world_size/2 | 0)+0.5)*ROOMS_SIZE*CELL_SIZE)
	#select rooms x number of times
	for i in total_rooms:
		getPosibleRoomLocations(posible_rooms, 1, EXTERNAL_LIMIT_GRID + 1)
		selectNewRoom(posible_rooms)
	#surround all rooms with walls
	getPosibleRoomLocations(posible_rooms, 3, EXTERNAL_LIMIT_GRID)
	calcFurthestCell(posible_rooms)
	#spawn rooms and walls
	spawnRooms(roomDict)
	#mapa
	
	map = self.get_children()
	generate_floor()
	generate_items()
	generate_enemy()
	emit_signal("world_generated")
	
	

func getPosibleRoomLocations(list, num, limit):
	for i in world_size:
		for j in world_size:
			if world[i][j] == 2:
				# check if available tile already listed, if dont, add it
				if i < world_size - limit:
					if world[i+1][j] != 2:
						world[i+1][j] = num
						if !list.has(Vector2(i+1,j)):
							list.append(Vector2(i+1,j))
				if i > 0:
					if world[i-1][j] != 2:
						world[i-1][j] = num
						if !list.has(Vector2(i-1,j)):
							list.append(Vector2(i-1,j))
				if j < world_size - limit:
					if world[i][j+1] != 2:
						world[i][j+1] = num
						if !list.has(Vector2(i,j+1)):
							list.append(Vector2(i,j+1))
				if j > 0:
					if world[i][j-1] != 2:
						world[i][j-1] = num
						if !list.has(Vector2(i,j-1)):
							list.append(Vector2(i,j-1))

func selectNewRoom(list):
	#randomly select one room from posibles
	var new_room_pos = list[randi() % list.size()]
	list.erase(new_room_pos)
	world[new_room_pos.x][new_room_pos.y] = 2
	
func spawnRooms(rooms):
	var room_start = load("res://scenes/Maps/roomstart.tscn").instance()
	var room_finish = load("res://scenes/Maps/roomfinish.tscn").instance()
	for i in world_size:
		for j in world_size:
			if world[i][j] == 2:
				if i == (world_size/2 | 0) and j == (world_size/2 | 0):
					#instance start room at center
					add_child(room_start)
					room_start.set_position(ROOMS_SIZE*CELL_SIZE*Vector2(world_size/2 | 0,world_size/2 | 0))
				else:
					#instance random hallway
					var new_room = rooms[randi() % rooms.size()].instance()
					add_child(new_room)
					new_room.set_position(CELL_SIZE*ROOMS_SIZE*Vector2(i,j))
			elif world[i][j] == 3:
					#instance wall
				var room_wall = load("res://scenes/Maps/roomwall.tscn").instance()
				add_child(room_wall)
				room_wall.set_position(CELL_SIZE*ROOMS_SIZE*Vector2(i,j))
			elif world[i][j] == 4:
				#instance exit
				add_child(room_finish)
				room_finish.set_position(CELL_SIZE*ROOMS_SIZE*Vector2(i,j))

func calcFurthestCell(list):
	var furthest_room = Vector2(0,0)
	var furthest = 0
	var distance = 0
	for room in list:
		distance = sqrt(pow((room.y - (world_size/2 | 0)),2) + pow((room.x - (world_size/2 | 0)),2))
		if distance > furthest:
			furthest = distance
			furthest_room = room
	world[furthest_room.x][furthest_room.y] = 4
	
	for n in range(-1,2,1):
		for m in range(-1,2,1):
			if world[furthest_room.x + n][furthest_room.y + m] == 0:
				world[furthest_room.x + n][furthest_room.y + m] = 3

#First create the new floor
func generate_floor():
	var new_floor= []
	for i in map:
		new_floor.append(i.get_used_cells_by_id(1)
		+i.get_used_cells_by_id(2)
		+i.get_used_cells_by_id(3)
		+i.get_used_cells_by_id(7)) 
	for i in range(len(map)):
		for j in new_floor[i]:
			self.set_cell(j[0]+map[i].global_position[0]/8,j[1]+map[i].global_position[1]/8,1)	

func generate_items():
	var rand_value = 0
	var tile_map = []
	var new_tile = []
	
	for i in map:
		if i.get_used_cells_by_id(3) != []:
			new_items.append([i,i.get_used_cells_by_id(3)])	
	#Keys
	for _i in range(3):
		rand_value = new_items[randi() % new_items.size()]
		tile_map = rand_value[0]
		rand_value.erase(tile_map)
		new_tile = rand_value[randi() % rand_value.size()]
		tile_map.set_cell(new_tile[0][0],new_tile[0][1],4)
		new_items.erase(rand_value)
		
	#Oil
	for i in map:
		if i.get_used_cells_by_id(3) != []:
			new_items.append([i,i.get_used_cells_by_id(3)])
	for _i in range(5):
		rand_value = new_items[randi() % new_items.size()]
		tile_map = rand_value[0]
		rand_value.erase(tile_map)
		new_tile = rand_value[randi() % rand_value.size()]
		tile_map.set_cell(new_tile[0][0],new_tile[0][1],5)
		new_items.erase(rand_value)

func generate_enemy():
	var rand_value = 0
	var tile_map = []
	var new_tile = []
	var enemy = load("res://scenes/Enemigos/Enemy.tscn")
	for i in map:
		if i.get_used_cells_by_id(7) != []:
			new_items.append([i,i.get_used_cells_by_id(7)])	
	for _i in range(1):
		get_parent().get_node("Enemies").add_child(enemy.instance())
		
	for i in get_parent().get_node("Enemies").get_children():
		rand_value = new_items[randi() % new_items.size()]
		tile_map = rand_value[0]
		rand_value.erase(tile_map)
		new_tile = rand_value[randi() % rand_value.size()]
		get_parent().get_node("Enemies/"+i.name).global_position = Vector2(
			new_tile[0][0]*8+tile_map.get_global_position()[0],
			new_tile[0][1]*8+tile_map.get_global_position()[1])
		new_items.erase(rand_value)
	

