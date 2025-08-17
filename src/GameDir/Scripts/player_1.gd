extends CharacterBody3D


var max_speed: float = 100.0
var ball_position_history: Array = []
var reaction_delay: float = 0.15

func _physics_process(delta: float) -> void:
	self.position.y = 0.09
	ball_position_history.append(GlobalVAR.ballPositionX)

	var frame_delay := int(reaction_delay / delta)
	if ball_position_history.size() > frame_delay:
		var target_x: float = ball_position_history[0]
		ball_position_history.remove_at(0)

		var dx: float = target_x - position.x
		var direction: float = sign(dx)
		var distance: float = abs(dx)

		if distance > 1.0:
			position.x += direction * min(max_speed * delta, distance)

	move_and_slide()
