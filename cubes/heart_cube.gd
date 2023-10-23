extends Node3D

@onready var mesh = $BaseCube/MeshInstance3D

func _ready():
	var material = mesh.get_active_material(0).duplicate() 
	material.albedo_color = Color(0.7, 0, 0, 0.7) 
	mesh.set_surface_override_material(0, material)

func _process(delta):
	pass
