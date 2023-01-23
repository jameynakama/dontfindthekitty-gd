extends Area2D


signal creature_caught(creature_type)


const MOVE_TIMEOUT = 0.2
const CHANCE_TO_WAIT = 0.8

var directions = [
    Vector2.UP,
    Vector2.RIGHT,
    Vector2.DOWN,
    Vector2.LEFT,
]

onready var ray = $RayCast2D

var type
var adjective


func set_initial_position(initial_position):
    position = initial_position
    return position


func _ready():
    var player = get_node("/root/Main/PlayArea/Player")
    player.connect("contacted_creature", self, "_contacted")

    adjective = Constants.ADJECTIVES[randi() % Constants.ADJECTIVES.size()]
    type = Constants.CREATURE_TYPES[randi() % Constants.CREATURE_TYPES.size()]
    $AnimatedSprite.frame = randi() % 253
    modulate = Color8((randi() % 206) + 50, (randi() % 206) + 50, (randi() % 206) + 50)

    $MoveTimer.start(MOVE_TIMEOUT)


func move():
    if randf() < CHANCE_TO_WAIT:
        return

    var target_position = directions[randi() % directions.size()] * Constants.TILE_SIZE
    ray.cast_to = target_position
    ray.force_raycast_update()
    if !ray.is_colliding() and randf() < 0.4:
        var future_position = position + target_position
        if future_position.x < 0 or future_position.x > Constants.PLAY_AREA.x \
            or future_position.y < 0 or future_position.y > Constants.PLAY_AREA.y:
            return
        position = future_position
    $MoveTimer.start(MOVE_TIMEOUT)


func _contacted(creature):
    if creature.get_instance_id() == get_instance_id():
        var creature_type = type

        get_tree().call_group("message", "queue_free")
        # TODO: Signal writer instead
        $Writer.write_message(
            "Caught %s %s" % [adjective, type],
            get_node("/root/Main/PlayArea")
        )

        Constants.creatures_left -= 1
        emit_signal("creature_caught", creature_type)

        queue_free()
