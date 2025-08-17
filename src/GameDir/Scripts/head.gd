extends Node3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if GlobalVAR.PlayerCanMove and not GlobalVAR.PlayerLookingConsole and not GlobalVAR.PlayerLookingSettings:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * GlobalVAR.MouseSpeed))
