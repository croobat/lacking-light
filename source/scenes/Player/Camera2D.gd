extends Camera2D

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var current_frame = 7
onready var num_frames = 8

func _ready():
	pass
	#var num_frames = get_sprite_frames().get_frame_count("animated_sprite")


func _on_Player_move():
	current_frame = (current_frame + 1) % num_frames
	animated_sprite.set_frame(current_frame)
