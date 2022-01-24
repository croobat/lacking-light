extends Label

func _process(_delta):
	set_text("Final Score: " + str(Data.player["Score"]))
