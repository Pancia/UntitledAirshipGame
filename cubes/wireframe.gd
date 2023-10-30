extends Node3D

var time_alive = 0.0
var time_to_grow
var resource
var realized = false

@onready var wireframe_mesh = $MeshInstance3D

func _process(delta):
	time_alive += delta
	if not realized and time_alive >= time_to_grow:
		var real = resource.instantiate()
		real.position = position + Vector3(0, -1, 0)
		remove_child(wireframe_mesh)
		add_child(real)
		realized = true
	elif not realized:
		wireframe_mesh.get_active_material(0).set_shader_parameter("appear_progress", time_alive / time_to_grow)
