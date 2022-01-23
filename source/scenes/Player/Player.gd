extends Area2D

signal move
var count = 0
onready var collider = get_node("RayCast2D")

func _ready():
	pass
	
func _physics_process(delta):
	#print(get_parent().get_node("Floor").get_cell(self.position.x/8,self.position.y/8))
	count = move(count)
	print(count)
	if count == 3:
		emit_signal("move")
		count = 0
		
func check_tile(posx,posy):
	var tile = get_parent().get_node("Floor").get_cell((self.position.x+posx)/8,(self.position.y+posy)/8)
	if tile == -1 or tile == 1:
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

