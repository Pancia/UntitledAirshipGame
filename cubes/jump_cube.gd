extends Node3D

@onready var label = $Label3D
var kind = "JUMP"

func _ready():
	label.text = "J"
