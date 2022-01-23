extends Area2D

func _ready():
	connect("area_entered",self,"_on_Key_area_entered")

func _on_Key_area_entered(area):
	Data.player["Key"]+=1
	self.queue_free()

