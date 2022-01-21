extends KinematicBody2D
signal move

func _ready():
	pass

func _physics_process(delta):
	if move():
		emit_signal("move")
	

func move():
	if Input.is_action_just_released("ui_up"):
		self.position.y -= 8
		emit_signal("move")
	if Input.is_action_just_released("ui_down"):
		self.position.y += 8
		emit_signal("move")
	if Input.is_action_just_released("ui_right"):
		self.position.x += 8
		emit_signal("move")
	if Input.is_action_just_released("ui_left"):
		self.position.x -= 8
		emit_signal("move")
		

