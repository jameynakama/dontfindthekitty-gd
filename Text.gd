extends Node


var Letter = load("res://Letter.tscn")


func write(message: String, pos: Vector2, prnt: Node, group: String = "permanent"):
    for i in range(message.length()):
        var letter = Letter.instance()
        letter.setup(message[i], Vector2(pos.x + (i * 20), pos.y))
        letter.add_to_group(group)
        prnt.add_child(letter)
