extends Node2D


export(PackedScene) var creature_scene


func initialize():
    randomize()
    get_tree().call_group("creatures", "queue_free")
    Constants.creatures_left = Constants.NUM_CREATURES
    Constants.messages = ["", "", ""]


func _ready():
    initialize()

    var area_separator = ""
    for _i in range(Constants.SCREEN_SIZE.x / Constants.TILE_SIZE):
        area_separator += "-"

    # Actually draw this with nicer glyphs
    $Writer.write(area_separator, Vector2(Constants.TILE_SIZE / 2, Constants.PLAY_AREA.y), $PlayArea)

    var used_positions = {
        get_node("PlayArea/Player").position: true
    }
    for _i in range(Constants.NUM_CREATURES - 1):
        create_creature(used_positions)
    create_creature(used_positions, true)

    var creatures = get_tree().get_nodes_in_group("creatures")
    for creature in creatures:
        creature.connect("creature_caught", self, "__creature_caught")


func create_creature(used_positions, is_kitty = false):
    while true:
        var creature = creature_scene.instance()
        var pos = get_random_position()
        if !used_positions.has(pos):
            used_positions[pos] = true
            creature.set_initial_position(pos)
            $PlayArea.add_child(creature)
            if is_kitty:
                creature.type = "kitty"
#                creature.get_node("AnimatedSprite").frame = 1 # DEBUG: kitty is filled smile
            break


func get_random_position():
    var random_x = randi() % int(Constants.PLAY_AREA.x) / Constants.TILE_SIZE
    var random_y = randi() % int(Constants.PLAY_AREA.y) / Constants.TILE_SIZE
    var random_position = Vector2(random_x * Constants.TILE_SIZE, random_y * Constants.TILE_SIZE)
    random_position = random_position.snapped(Vector2.ONE * Constants.TILE_SIZE)
    random_position += Vector2.ONE * (Constants.TILE_SIZE / 2)
    return random_position


func __creature_caught(creature_type):
    if creature_type == "kitty" and Constants.creatures_left >= 1:
        print("GAME OVER!")
        get_tree().change_scene(get_tree().current_scene.filename)
    elif Constants.creatures_left == 1:
        print("YOU WIN!")
        get_tree().change_scene(get_tree().current_scene.filename)
