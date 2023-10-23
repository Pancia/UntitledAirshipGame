extends StaticBody3D

@onready var mesh = $MeshInstance3D

func highlight():
	var material = mesh.get_active_material(0).duplicate() 
	material.albedo_color = Color(1, 0, 0, 1) 
	mesh.set_surface_override_material(0, material)
	
func unhighlight():
	mesh.set_surface_override_material(0, null)
