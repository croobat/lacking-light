extends Label

func _process(_delta):
	set_text("Score: " + str(Data.player["Score"]))
