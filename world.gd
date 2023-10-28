extends Node3D

var starter_cube_res = preload("res://cubes/starter_cube.tscn")
var heart_cube_res = preload("res://cubes/heart_cube.tscn")
var jump_cube_res = preload("res://cubes/jump_cube.tscn")

func _ready():
	for x in range(0, 10):
		for z in range(0, 10):
			var newCube
			if (x == 5 and z == 5):
				print("instantiate heart cube")
				newCube = heart_cube_res.instantiate()
			elif (x == 3 and z == 3):
				newCube = jump_cube_res.instantiate()
			else:
				newCube = starter_cube_res.instantiate()
			newCube.position = Vector3(x, 0, z)
			add_child(newCube)

func _process(delta):
	pass
