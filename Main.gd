extends Node


export(PackedScene) var aminal_scene


func _ready():
	randomize()


func _process(delta):
	if Input.is_action_just_pressed("enter"):
		var aminal = aminal_scene.instance()
		add_child(aminal)
	
	if Input.is_action_just_pressed("space"):
		get_tree().call_group("aminals", "queue_free")

