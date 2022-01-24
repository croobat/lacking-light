extends Label

func _process(_delta):
	set_text("Level: " + str(Data.player["Level"]))
