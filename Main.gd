extends Node2D


export(PackedScene) var aminal_scene

const NUM_AMINALS = 75
const TILE_SIZE = 20

var screen_size


func _ready():
	randomize()
	screen_size = get_viewport_rect().size

	var used_positions = {}
	for i in range(NUM_AMINALS):
		var aminal = aminal_scene.instance()
		while true:
			var pos = get_random_position()
			if !used_positions.has(pos):
				used_positions[pos] = true
				aminal.setup(pos)
				$PlayArea.add_child(aminal)
				break


func get_random_position():
	var random_x = randi() % int(screen_size.x) / TILE_SIZE
	var random_y = randi() % int(screen_size.y) / TILE_SIZE
	var random_position = Vector2(random_x * TILE_SIZE, random_y * TILE_SIZE)
	random_position = random_position.snapped(Vector2.ONE * TILE_SIZE)
	random_position += Vector2.ONE * (TILE_SIZE / 2)
	return random_position
