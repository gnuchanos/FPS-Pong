extends CharacterBody3D

var SPEED = 2
var timer = 5

func _followBall():
	GlobalVAR.ballPositionX = self.position.x

func _outside():
	if GlobalVAR.ballOutside:
		self.position.x = 0.27
		self.position.z = -40.732
		self.position.y = 2.336
		GlobalVAR.MaxSpeed = GlobalVAR.MaxSpeed
		timer = 5

func _moveAndRotate(delta):
	$ball.rotate_y(25 * delta)

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not GlobalVAR.ballOutside:
		if timer > 0:
			timer -= delta
			SPEED = 2
		else:
			velocity.x = GlobalVAR.ballSpeedX * SPEED
			velocity.z = GlobalVAR.ballSpeedZ * SPEED
			move_and_slide()

			SPEED += 0.1 * delta
			GlobalVAR.MaxSpeed += 0.1 * delta
			SPEED = clamp(SPEED, GlobalVAR.MinSpeed, GlobalVAR.MaxSpeed)


func _physics_process(delta: float) -> void:
	_followBall()
	_outside()
	_moveAndRotate(delta)
