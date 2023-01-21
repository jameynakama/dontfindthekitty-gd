extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func setup(message: String, pos: Vector2):
    $AnimatedSprite.frame = Constants.CHAR_MAP[message]
    $AnimatedSprite.position = pos
