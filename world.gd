extends Node3D

var starter_cube_res = preload("res://cubes/starter_cube.tscn")
var heart_cube_res = preload("res://cubes/heart_cube.tscn")
var jump_cube_res = preload("res://cubes/jump_cube.tscn")

var paused = false

signal pause
signal unpause

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	for x in range(0, 10):
		for z in range(0, 10):
			var newCube
			if (x == 4 and z == 2):
				newCube = heart_cube_res.instantiate()
			elif (x == 5 and z == 3):
				newCube = jump_cube_res.instantiate()
			else:
				newCube = starter_cube_res.instantiate()
			newCube.position = Vector3(x-5, 0, -z)
			add_child(newCube)

func pause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#get_tree().paused = true #In case you want to pause the game
	pause.emit()

func unpause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#get_tree().paused = false
	unpause.emit()

func _process(_delta):
	if Input.is_action_just_released("game_pause"):
		paused = !paused
		if paused:
			pause_game()
		else:
			unpause_game()
