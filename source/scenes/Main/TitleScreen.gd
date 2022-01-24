extends Control

var scene_path_to_load

func _ready():
	for button in $Menu/Buttons.get_children():
		button.connect("pressed", self, "on_Button_pressed", [button.scene_to_load])

#func _on_NewGameButton_pressed():
#	get_tree().change_scene("res://scenes/Main/Gamescene.tscn")

#func _on_CreditsButton_pressed():
#	get_tree().change_scene("res://scenes/Main/Credits.tscn")

func on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
