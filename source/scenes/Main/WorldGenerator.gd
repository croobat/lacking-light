extends Node2D

const TOTAL_NUMBER_OF_ROOMS = 8
const START_ROOM_COUNT = 3
const ROOM_INCREASE_PER_LEVEL = 2
const EXIT_ROOM_IND = 9
const START_ROOM_IND = 0

const CELL_SIZE = 14
const ROOMS_SIZE = 7
const WORLD_SIZE = 10

var roomDict = {}
var world = []
var posible_rooms = []
var occupied_rooms = []

func _ready():
	randomize()
	#loading room templates
	for room_num in (TOTAL_NUMBER_OF_ROOMS):
		roomDict[room_num] = load("res://scenes/Maps/room" + str(room_num) + ".tscn")
	#var room_start = load("res://scenes/Maps/roomstart.tscn").instance()
	#var room_finish = load("res://scenes/Maps/roomfinish.tscn").instance()
	
	#generate world grid
		#0 means empty, 1 means spawnable, 2 means occupied, 3 means block
	for i in WORLD_SIZE:
		world.append([])
		world[i].resize(WORLD_SIZE)
		for j in WORLD_SIZE:
			world[i][j] = 0

	world[WORLD_SIZE/2 | 0][WORLD_SIZE/2 | 0] = 2
	
	for i in 25:
		getPosibleRoomLocations(posible_rooms, 1)
		selectNewRoom(posible_rooms)
	spawnRooms(roomDict)
	spawnWalls()
	

func getPosibleRoomLocations(list, num):
	for i in WORLD_SIZE:
		for j in WORLD_SIZE:
			if world[i][j] == 2:
				# check if available tile already listed, if dont, add it
				if i < WORLD_SIZE - 1:
					if world[i+1][j] != 2:
						world[i+1][j] = num
						if !list.has(Vector2(i+1,j)):
							list.append(Vector2(i+1,j))
				if i > 0:
					if world[i-1][j] != 2:
						world[i-1][j] = num
						if !list.has(Vector2(i-1,j)):
							list.append(Vector2(i-1,j))
				if j < WORLD_SIZE - 1:
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
	#randomly select one room from available
	var new_room_pos = list[randi() % list.size()]
	list.erase(new_room_pos)
	world[new_room_pos.x][new_room_pos.y] = 2
	
func spawnRooms(rooms):
	for i in WORLD_SIZE:
		for j in WORLD_SIZE:
			if world[i][j] == 2:
				if i == (WORLD_SIZE/2 | 0) and j == (WORLD_SIZE/2 | 0):
					#instance start room at center
					var room_start = load("res://scenes/Maps/roomstart.tscn").instance()
					var room_finish = load("res://scenes/Maps/roomfinish.tscn").instance()
					add_child(room_start)
					room_start.set_position(ROOMS_SIZE*CELL_SIZE*Vector2(WORLD_SIZE/2 | 0,WORLD_SIZE/2 | 0))
				else:
					var new_room = rooms[randi() % rooms.size()].instance()
					add_child(new_room)
					new_room.set_position(CELL_SIZE*ROOMS_SIZE*Vector2(i,j))
	
func spawnWalls():
	getPosibleRoomLocations()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
