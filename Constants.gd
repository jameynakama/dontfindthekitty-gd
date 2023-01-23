extends Node2D


const NUM_CREATURES = 3
const TILE_SIZE = 20
onready var SCREEN_SIZE = get_viewport_rect().size
onready var PLAY_AREA = SCREEN_SIZE - (Vector2(0, 4) * TILE_SIZE)
onready var MESSAGE_AREA = Vector2(
    (1 * TILE_SIZE) + (TILE_SIZE / 2),
    PLAY_AREA.y + (1 * TILE_SIZE)
)

var CREATURE_TYPES = []
var ADJECTIVES = []

# This tracks existing creatures. It feels redundant, since get_nodes_in_group
# exists, but queue_free doesn't happen till after the current frame, so
# checking it is problematic due to race conditions.
var creatures_left := 0
var messages = ["", "", ""]


func _ready():
    read_file_into_array("creatures.txt", CREATURE_TYPES)
    read_file_into_array("adjectives.txt", ADJECTIVES)


func read_file_into_array(filename: String, arr: Array):
    var file = File.new()
    file.open("res://assets//%s" % filename, File.READ)
    while !file.eof_reached():
        var line = file.get_line()
        if line:
            arr.append(line)
    file.close()


const CHAR_MAP = {
    " ": 0,
    "!": 1,
    '"': 2,
    "#": 3,
    "$": 4,
    "%": 5,
    "'": 6,
    "(": 7,
    ")": 8,
    "*": 9,
    "+": 10,
    ",": 11,
    "-": 12,
    ".": 13,
    "/": 14,
    "0": 15,
    "1": 16,
    "2": 17,
    "3": 18,
    "4": 19,
    "5": 20,
    "6": 21,
    "7": 22,
    "8": 23,
    "9": 24,
    ":": 25,
    ";": 26,
    "<": 27,
    "=": 28,
    ">": 29,
    "?": 30,
    "@": 31,
    "A": 32,
    "B": 33,
    "C": 34,
    "D": 35,
    "E": 36,
    "F": 37,
    "G": 38,
    "H": 39,
    "I": 40,
    "J": 41,
    "K": 42,
    "L": 43,
    "M": 44,
    "N": 45,
    "O": 46,
    "P": 47,
    "Q": 48,
    "R": 49,
    "S": 50,
    "T": 51,
    "U": 52,
    "V": 53,
    "W": 54,
    "X": 55,
    "Y": 56,
    "Z": 57,
    "[": 58,
    "\\": 59,
    "]": 60,
    "^": 61,
    "_": 62,
    "`": 63,
    "a": 64,
    "b": 65,
    "c": 66,
    "d": 67,
    "e": 68,
    "f": 69,
    "g": 70,
    "h": 71,
    "i": 72,
    "j": 73,
    "k": 74,
    "l": 75,
    "m": 76,
    "n": 77,
    "o": 78,
    "p": 79,
    "q": 80,
    "r": 81,
    "s": 82,
    "t": 83,
    "u": 84,
    "v": 85,
    "w": 86,
    "x": 87,
    "y": 88,
    "z": 89,
    "{": 90,
    "|": 91,
    "}": 92,
    "~": 93,
}
