extends Node2D


onready var SCREEN_SIZE = get_viewport_rect().size
var AMINAL_TYPES = []
var ADJECTIVES = []

func _ready():
    read_file_into_array("aminals.txt", AMINAL_TYPES)
    read_file_into_array("adjectives.txt", ADJECTIVES)

func read_file_into_array(filename: String, arr: Array):
    var file = File.new()
    file.open("res://assets//%s" % filename, File.READ)
    while !file.eof_reached():
        var line = file.get_line()
        if line:
            arr.append(line)
    file.close()
