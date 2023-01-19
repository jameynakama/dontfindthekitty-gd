extends Node


export(PackedScene) var aminal_scene

const NUM_AMINALS = 75


func _ready():
	randomize()
	
	for i in range(NUM_AMINALS):
		add_child(aminal_scene.instance())


func _process(delta):
	if Input.is_action_just_pressed("enter"):
		var aminal = aminal_scene.instance()
		add_child(aminal)
	
	if Input.is_action_just_pressed("space"):
		get_tree().call_group("aminals", "queue_free")
