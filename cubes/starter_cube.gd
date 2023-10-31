extends Node3D

var kind = "STARTER"

func highlight():
	$Label3D.text = "L"

func unhighlight():
	$Label3D.text = "0"
