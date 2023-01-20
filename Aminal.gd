extends Area2D

const TILE_SIZE = 20
const MOVE_TIMEOUT = 0.2
const CHANCE_TO_WAIT = 0.8

var directions = [
    Vector2.UP,
    Vector2.RIGHT,
    Vector2.DOWN,
    Vector2.LEFT,
]

onready var ray = $RayCast2D
onready var Constants = $"/root/Constants"


func set_initial_position(initial_position):
    position = initial_position
    return position


func _ready():
    randomize()

    $AnimatedSprite.frame = randi() % 253
    modulate = Color8((randi() % 206) + 50, (randi() % 206) + 50, (randi() % 206) + 50)
    $MoveTimer.start(MOVE_TIMEOUT)


func move():
    if randf() < CHANCE_TO_WAIT:
        return

    var target_position = directions[randi() % directions.size()] * TILE_SIZE
    ray.cast_to = target_position
    ray.force_raycast_update()
    if !ray.is_colliding() and randf() < 0.4:
        var future_position = position + target_position
        if future_position.x < 0 or future_position.x > Constants.SCREEN_SIZE.x \
            or future_position.y < 0 or future_position.y > Constants.SCREEN_SIZE.y:
            return
        position = future_position
    $MoveTimer.start(MOVE_TIMEOUT)
