extends Node3D

var time_alive = 0.0
var time_to_grow
var resource
var realized = false
var offset = Vector3(0, -1, 0)
var seed_kind

@onready var wireframe_mesh = $MeshInstance3D

func _ready():
	if seed_kind:
		var color
		match seed_kind:
			Seed.SeedKind.BOMB: color = Color("f00")
			Seed.SeedKind.BRIDGE: color = Color("700c")
			Seed.SeedKind.FRUIT: color = Color("0c0")
			Seed.SeedKind.JUMP: color = Color("00f")
			Seed.SeedKind.CASTLE: color = Color("f0f")
			Seed.SeedKind.HEART: color = Color("9009")
			Seed.SeedKind.SAND: color = Color("3ffd")
			Seed.SeedKind.ICE: color = Color("027")
		var mat = wireframe_mesh.get_active_material(0)
		if mat is ShaderMaterial:
			mat.set_shader_parameter("wire_color", color)
		else:
			mat.albedo_color = color

func _process(delta):
	time_alive += delta
	if not realized and time_alive >= time_to_grow:
		var real = resource.instantiate()
		real.position = position + offset
		remove_child(wireframe_mesh)
		add_child(real)
		realized = true
	elif not realized:
		wireframe_mesh.get_active_material(0).set_shader_parameter("appear_progress", time_alive / time_to_grow)
