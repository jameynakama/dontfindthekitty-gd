extends Node2D


export(PackedScene) var creature_scene

const NUM_CREATURES = 2


func _ready():
    randomize()

    var area_separator = ""
    for _i in range(Constants.SCREEN_SIZE.x / Constants.TILE_SIZE):
        area_separator += "-"

    # Actually draw this with nicer glyphs
    $Writer.write(area_separator, Vector2(Constants.TILE_SIZE / 2, Constants.PLAY_AREA.y), $PlayArea)

    var used_positions = {
        get_node("PlayArea/Player").position: true
    }
    for _i in range(NUM_CREATURES):
        var creature = creature_scene.instance()
        while true:
            var pos = get_random_position()
            if !used_positions.has(pos):
                used_positions[pos] = true
                creature.set_initial_position(pos)
                $PlayArea.add_child(creature)
                break
        var kitty = get_node("PlayArea/Creature")
        kitty.type = "kitty"


func get_random_position():
    var random_x = randi() % int(Constants.PLAY_AREA.x) / Constants.TILE_SIZE
    var random_y = randi() % int(Constants.PLAY_AREA.y) / Constants.TILE_SIZE
    var random_position = Vector2(random_x * Constants.TILE_SIZE, random_y * Constants.TILE_SIZE)
    random_position = random_position.snapped(Vector2.ONE * Constants.TILE_SIZE)
    random_position += Vector2.ONE * (Constants.TILE_SIZE / 2)
    return random_position
