extends Node3D
	
var bridge_cube_res = preload("res://cubes/bridge_cube.tscn")
var wireframe_res = preload("res://cubes/wireframe.tscn")
var time_to_grow = 1
var spawned_child = false
var kind = "BRIDGE"

@onready var label = $Label3D

func _ready():
	label.text = "B%s" % time_to_grow

func _process(delta):
	if not spawned_child:
		var growth = wireframe_res.instantiate()
		growth.offset = Vector3(1, 0, 0)
		growth.position = position + Vector3(-1, 0, 0)
		growth.resource = bridge_cube_res
		growth.time_to_grow = time_to_grow
		growth.seed_kind = Seed.SeedKind.BRIDGE
		add_child(growth)
		spawned_child = true
