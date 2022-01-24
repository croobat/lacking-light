extends HSlider

func _ready():
	self.value = Data.player["Oil"]

func _physics_process(delta):
	self.value = Data.player["Oil"]

func _on_mouse_entered():
	self.release_focus()
