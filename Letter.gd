extends Node


func setup(message: String, pos: Vector2):
    $AnimatedSprite.frame = Constants.CHAR_MAP[message]
    $AnimatedSprite.position = pos
