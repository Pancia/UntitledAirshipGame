extends Node3D

var base_cube_res = preload("res://cubes/base_cube.tscn")
var heart_cube_res = preload("res://cubes/heart_cube.tscn")

func _ready():
	for x in range(0, 10):
		for z in range(0, 10):
			var newCube
			if (x == 5 and z == 5):
				print("instantiate heart cube")
				newCube = heart_cube_res.instantiate()
			else:
				newCube = base_cube_res.instantiate()
			newCube.position = Vector3(x, 0, z)
			add_child(newCube)

func _process(delta):
	pass
