extends Node3D

var heart_cube_res = preload("res://cubes/heart_cube.tscn")
var wireframe_res = preload("res://cubes/wireframe.tscn")
var time_to_grow = 5
var spawned_child = false
var kind = "HEART"

@onready var label = $Label3D

func _process(delta):
	if not spawned_child:
		var growth = wireframe_res.instantiate()
		growth.position = position + Vector3(0, 1, 0)
		growth.resource = heart_cube_res
		growth.time_to_grow = time_to_grow
		growth.seed_kind = Seed.SeedKind.HEART
		add_child(growth)
		spawned_child = true
