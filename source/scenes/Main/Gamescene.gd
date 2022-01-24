extends Node2D

func _ready():
	$MusicLevel.play()
	Data.player["Oil"] = 8
	Data.player["Keys"] = 0

func _on_Player_turnStep():
	if Data.player["Oil"] <= 0:
		get_tree().change_scene("res://scenes/Main/GameOver.tscn")

func _process(delta):
	if Data.player["Oil"] <= 0:
		get_tree().change_scene("res://scenes/Main/GameOver.tscn")
