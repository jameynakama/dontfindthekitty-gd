extends Area2D


var screen_size
var tile_size = 20
var inputs = {
	"move_up": Vector2.UP,
	"move_right": Vector2.RIGHT,
	"move_down": Vector2.DOWN,
	"move_left": Vector2.LEFT,
}

onready var ray = $RayCast2D


func _ready():
	screen_size = get_viewport_rect().size
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2


func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	var target_position = inputs[dir] * tile_size
	ray.cast_to = target_position
	ray.force_raycast_update()
	if !ray.is_colliding():
		var future_position = position + target_position
		if future_position.x < 0 or future_position.x > screen_size.x \
			or future_position.y < 0 or future_position.y > screen_size.y:
			return
		position = future_position
