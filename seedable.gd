extends Node3D

const wireframe_res = preload("res://cubes/wireframe.tscn")
var current_seed
var spawned_child = false

func plant(kind: Seed.SeedKind):
	var seed = Seed.new()
	seed.kind = kind
	current_seed = seed

func _process(delta):
	if not spawned_child and current_seed:
		var growth = wireframe_res.instantiate()
		growth.position = position + Vector3(0, 1, 0)
		growth.resource = current_seed.resource()
		growth.time_to_grow = current_seed.growTime()
		add_child(growth)
		spawned_child = true
