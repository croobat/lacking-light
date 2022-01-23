extends Area2D

signal move
onready var collider = get_node("RayCast2D")

func _ready():
	pass
	
func _physics_process(delta):
	print(get_parent().get_node("Floor").get_cell(self.position.x/8,self.position.y/8))
	move()
	
func check_tile(posx,posy):
	var tile = get_parent().get_node("Floor").get_cell((self.position.x+posx)/8,(self.position.y+posy)/8)
	if tile == -1 or tile == 1:
		return false
	else:
		return true

func move():
	if Input.is_action_just_released("ui_up") and check_tile(0,-8):
		self.position.y -= 8
		emit_signal("move")
	if Input.is_action_just_released("ui_down") and check_tile(0,8):
		self.position.y += 8
		emit_signal("move")
	if Input.is_action_just_released("ui_right") and check_tile(8,0):
		self.position.x += 8
		emit_signal("move")
	if Input.is_action_just_released("ui_left") and check_tile(-8,0):
		self.position.x -= 8
		emit_signal("move")
		

