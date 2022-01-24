extends Node

func _ready():
	if Data.player["Level"] > 1:
		self.visible = false
	pass
