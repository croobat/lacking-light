extends Area2D

signal move
var count = 0
onready var map = get_parent().get_node("TileMap")
onready var collider = get_node("RayCast2D")

func _ready():
	connect("move",map,"_on_Player_move")
	
func _physics_process(delta):
	#print(get_parent().get_node("Floor").get_cell(self.position.x/8,self.position.y/8))
	count = move(count)
	if count == 3:
		emit_signal("move")
		count = 0

func check_tile(posx,posy):
	var tile = map.get_cell((self.position.x+posx)/8,(self.position.y+posy)/8)
	if tile == -1 or tile == 0:
		return false
	elif tile == 2:
		if Data.player["Key"] > 0:
			Data.player["Key"] -= 1
			map.set_cell((self.position.x+posx)/8,(self.position.y+posy)/8,1)
		else:
			return false
	else:
		return true

func move(count):
	if Input.is_action_just_released("ui_up") and check_tile(0,-8):
		self.position.y -= 8
		count+=1
	if Input.is_action_just_released("ui_down") and check_tile(0,8):
		self.position.y += 8
		count+=1
	if Input.is_action_just_released("ui_right") and check_tile(8,0):
		self.position.x += 8
		count+=1
	if Input.is_action_just_released("ui_left") and check_tile(-8,0):
		self.position.x -= 8
		count+=1
	return	count	

