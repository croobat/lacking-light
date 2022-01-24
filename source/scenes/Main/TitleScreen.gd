extends Control

var scene_path_to_load

onready var sound_button: AudioStreamPlayer = get_node("SoundButtonPressed")
onready var sound_intro: AudioStreamPlayer = get_node("SoundIntro")
onready var intro_played = false

func _ready():
	Data.player["Score"] = 0
	Data.player["Level"] = 1
	sound_intro.play()
	
	for button in $Menu/Buttons.get_children():
		button.connect("pressed", self, "on_Button_pressed", [button.scene_to_load])

func on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	sound_button.play()
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
