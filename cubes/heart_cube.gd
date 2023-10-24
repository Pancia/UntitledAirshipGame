extends BaseCube

var heart_cube_res = preload("res://cubes/heart_cube.tscn")
var start_time = 0
var time_to_grow = 5
var grew = false

func _init():
	kind = "HEART"

func _ready():
	start_time = Time.get_ticks_msec()
	label.text = "H%s" % time_to_grow

func _process(delta):
	var seconds_elapsed = floor((Time.get_ticks_msec() - start_time)/1000)
	label.text = "H%s" % max(0, (time_to_grow - seconds_elapsed))
	if not grew and seconds_elapsed >= time_to_grow:
		var growth = heart_cube_res.instantiate()
		growth.position = position + Vector3(0, 1, 0)
		add_child(growth)
		grew = true

func highlight():
	pass

func unhighlight():
	pass
