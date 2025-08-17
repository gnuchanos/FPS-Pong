extends Node3D

var rot_speed := 190.0 # derece/sn
var min_angle := -60.0
var max_angle := 60.0
var current_angle := 0.0

func _process(delta: float) -> void:
	var axis := global_transform.basis.y.normalized()

	# sola
	if Input.is_action_pressed("a"):
		var step := rot_speed * delta
		if current_angle + step > max_angle:
			step = max_angle - current_angle
		current_angle += step
		rotate(axis, deg_to_rad(step))

	# sağa
	elif Input.is_action_pressed("d"):
		var step := rot_speed * delta
		if current_angle - step < min_angle:
			step = current_angle - min_angle
		current_angle -= step
		rotate(axis, deg_to_rad(-step))
