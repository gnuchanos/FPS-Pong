extends CharacterBody3D

var max_speed: float = 100.0
var follow_smooth: float = 15.0  # Tepki hızı

func _process(delta: float) -> void:
	GlobalVAR.AIMaxDelay = max(GlobalVAR.AIDelayMin, GlobalVAR.AIMaxDelay - 0.1 * delta)
	GlobalVAR.AIDelayCurrent = clamp(GlobalVAR.AIDelayCurrent, GlobalVAR.AIDelayMin, GlobalVAR.AIMaxDelay)

func _physics_process(delta: float) -> void:
	var pos := global_position
	pos.y = 0.09
	global_position = pos

	var target_x: float = GlobalVAR.ballPositionX
	var dx: float = target_x - global_position.x

	velocity.x = lerp(velocity.x, dx * follow_smooth, delta)
	move_and_slide()
