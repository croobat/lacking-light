extends Label

func _process(_delta):
	set_text("Keys: " + str(Data.player["Key"]))
