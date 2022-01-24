extends Node2D

func _on_Player_turnStep():
	if Data.player["Oil"] <= 0:
		get_tree().change_scene("res://scenes/Main/GameOver.tscn")
