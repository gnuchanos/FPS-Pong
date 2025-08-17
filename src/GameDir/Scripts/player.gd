extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 4.5
@onready var SettingsWindow = $UI/settings
@onready var Camera = $head/Camera3D



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if GlobalVAR.PlayerLookingSettings:
			GlobalVAR.PlayerLookingSettings = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			SettingsWindow.hide()
			GlobalVAR.pausedMode = false
		else:
			GlobalVAR.PlayerLookingSettings = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			SettingsWindow.show()
			GlobalVAR.pausedMode = true

	# i hope this is can't be performance problem
	Camera.fov = GlobalVAR.PlayerFOV_Current





func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("a", "d", "null", "null")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
