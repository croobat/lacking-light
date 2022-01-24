extends Control

onready var sound_button: AudioStreamPlayer = get_node("SoundButtonPressed")

func _on_Button_pressed():
	sound_button.play()
	


func _on_SoundButtonPressed_finished():
	get_tree().change_scene("res://scenes/Main/TitleScreen.tscn")
