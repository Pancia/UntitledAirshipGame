class_name BaseCube
extends StaticBody3D

@onready var mesh = $MeshInstance3D
@onready var label = $Label3D

var kind = "BASE"

func _ready():
	label.text = ""

func highlight():
	pass

func unhighlight():
	pass
