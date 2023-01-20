extends Node2D


export(PackedScene) var aminal_scene

const NUM_AMINALS = 75
const TILE_SIZE = 20

onready var Constants = $"/root/Constants"


func _ready():
    randomize()

    var used_positions = {}
    for i in range(NUM_AMINALS):
        var aminal = aminal_scene.instance()
        while true:
            var pos = get_random_position()
            if !used_positions.has(pos):
                used_positions[pos] = true
                aminal.set_initial_position(pos)
                $PlayArea.add_child(aminal)
                break


func get_random_position():
    var random_x = randi() % int(Constants.SCREEN_SIZE.x) / TILE_SIZE
    var random_y = randi() % int(Constants.SCREEN_SIZE.y) / TILE_SIZE
    var random_position = Vector2(random_x * TILE_SIZE, random_y * TILE_SIZE)
    random_position = random_position.snapped(Vector2.ONE * TILE_SIZE)
    random_position += Vector2.ONE * (TILE_SIZE / 2)
    return random_position
