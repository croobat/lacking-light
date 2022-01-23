extends Area2D

func _ready():
	connect("area_entered",self,"_on_Oil_area_entered")
	
func _on_Oil_area_entered(area):
	Data.player["Oil"]+=1
	self.queue_free()
