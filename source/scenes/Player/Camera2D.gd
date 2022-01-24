extends Camera2D

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var current_frame = Data.player["Oil"]

func _ready():
	animated_sprite.set_frame(current_frame)

func _process(delta):
	animated_sprite.set_frame(current_frame)
	current_frame = Data.player["Oil"]
