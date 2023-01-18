extends AnimatedSprite


var screen_size


func _ready():
	print('aminal ready')
	screen_size = get_viewport_rect().size
	position.x = randi() % int(screen_size.x / 20) * 20
	position.y = randi() % int(screen_size.y / 20) * 20
	frame = randi() % 256
	modulate = Color8(randi() % 226 + 30, randi() % 226 + 30, randi() % 226 + 30)
	print('aminal at position', position)


