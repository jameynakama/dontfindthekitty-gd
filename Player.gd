extends Area2D


signal contacted_creature(creature)


var inputs = {
    "move_up": Vector2.UP,
    "move_right": Vector2.RIGHT,
    "move_down": Vector2.DOWN,
    "move_left": Vector2.LEFT,
}

onready var ray = $RayCast2D


func _ready():
    position = Vector2(Constants.PLAY_AREA.x / 2, Constants.PLAY_AREA.y / 2)
    position = position.snapped(Vector2.ONE * Constants.TILE_SIZE)
    position += Vector2.ONE * Constants.TILE_SIZE / 2


func _unhandled_input(event):
    for dir in inputs.keys():
        if event.is_action_pressed(dir):
            move(dir)


func move(dir):
    var target_position = inputs[dir] * Constants.TILE_SIZE
    ray.cast_to = target_position
    ray.force_raycast_update()
    if !ray.is_colliding():
        var future_position = position + target_position
        # TODO: Refactor out-of-bounds code
        if future_position.x < 0 or future_position.x > Constants.PLAY_AREA.x \
            or future_position.y < 0 or future_position.y > Constants.PLAY_AREA.y:
            return
        position = future_position
    else:
        emit_signal("contacted_creature", ray.get_collider())
