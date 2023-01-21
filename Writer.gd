extends Node


var Letter = load("res://Letter.tscn")


func write(message: String, pos: Vector2, prnt: Node, group: String = "permanent"):
    for i in range(message.length()):
        var letter = Letter.instance()
        letter.setup(message[i], Vector2(pos.x + (i * 20), pos.y))
        letter.add_to_group(group)
        prnt.add_child(letter)


func write_message(message: String, prnt: Node):
    Constants.messages.push_front(message)
    Constants.messages.resize(3)
    get_tree().call_group("messages", "queue_free")

    # TODO: Show animal in cage like [@] with its color
    # Probably need to store the animal info in the array, not just strings,
    # as well as figure out how to pass frames (or just redo the CHAR_MAP...)
    for message_index in Constants.messages.size():
        var msg = Constants.messages[message_index]
        var msg_y = Constants.MESSAGE_AREA.y + (message_index * Constants.TILE_SIZE)
        for letter_index in range(msg.length()):
            var letter = Letter.instance()
            var letter_pos = Vector2(((letter_index + 1) * Constants.TILE_SIZE) + Constants.TILE_SIZE / 2, msg_y)
            letter.setup(msg[letter_index], letter_pos)
            var gray = int(250 / (message_index + 1))
            letter.get_node("AnimatedSprite").set_modulate(Color8(gray, gray, gray))
            letter.add_to_group("messages")
            prnt.add_child(letter)
