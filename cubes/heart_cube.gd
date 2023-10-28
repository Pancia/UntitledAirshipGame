extends BaseCube

var heart_cube_res = preload("res://cubes/heart_cube.tscn")
var time_alive = 0.0
var time_to_grow = 5
var spawned_child = false

func _init():
	kind = "HEART"

func _ready():
	label.text = "H%s" % time_to_grow

func _process(delta): #delta: Seconds
	time_alive += delta
	label.text = "H%.1f" % max(0, (time_to_grow - time_alive))
	if not spawned_child and time_alive >= time_to_grow:
		var growth = heart_cube_res.instantiate()
		growth.position = position + Vector3(0, 1, 0)
		add_child(growth)
		spawned_child = true

func highlight():
	pass

func unhighlight():
	pass
