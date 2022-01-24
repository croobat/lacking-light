extends Area2D

func _ready():
	connect("area_entered",self,"_on_Door_area_entered")
	
func _on_Door_area_entered(area):
	if Data.player["Key"] > 0:	
		Data.player["Key"]-=1
		self.queue_free()
	else:
		pass
