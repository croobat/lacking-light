extends Area2D

signal move
signal turnStep
var count = 0
var turnsteps = 0
const STEPS_PER_TURN = 5
const ENEMY_STEP_COUNT = 2

var not_allowed = [-1,0]

#onready var map = get_parent().get_node("Node2D/TileMap2")
onready var map = get_parent().get_node("WorldGenerator").get_children()
onready var Nodo_mapa = get_parent().get_node("WorldGenerator")
onready var camera = get_node("Camera2D")

func _ready():
	connect("move",Nodo_mapa,"_on_Player_move")
	#connect("turnStep",camera,"_on_Player_turnStep")


func _physics_process(delta):
	var steps = move(turnsteps, count)
	turnsteps = steps[0]
	count = steps[1]
	#[turnsteps, count] = move(turnsteps, count]
	if count == ENEMY_STEP_COUNT:
		emit_signal("move")
		count = 0
	if turnsteps == STEPS_PER_TURN:
		turnStep(turnsteps)
		emit_signal("turnStep")
		turnsteps = 0

func check_tile(posx,posy):
	for i in range(len(map)):
		var tile = map[i].get_cell((
			self.position.x+posx-map[i].global_position[0])/8,
			(self.position.y+posy-map[i].global_position[1])/8
			)
		if tile in not_allowed:
			continue
		elif tile == 2:
			if Data.player["Key"] > 0:
				Data.player["Key"] -= 1
				map.set_cell((self.position.x+posx)/8,(self.position.y+posy)/8,1)
			else:
				continue	
		else:
			return true
	return false
func move(turnsteps,count):
	if Input.is_action_just_released("ui_up") and check_tile(0,-8):
		self.position.y -= 8
		count+=1
		turnsteps += 1
	if Input.is_action_just_released("ui_down") and check_tile(0,8):
		self.position.y += 8
		count+=1
		turnsteps += 1
	if Input.is_action_just_released("ui_right") and check_tile(8,0):
		self.position.x += 8
		count+=1
		turnsteps += 1
	if Input.is_action_just_released("ui_left") and check_tile(-8,0):
		self.position.x -= 8
		count+=1
		turnsteps += 1
	return	[turnsteps,count]

func turnStep(turnsteps):
	if Data.player["Oil"] > 0:
		Data.player["Oil"] -= 1

