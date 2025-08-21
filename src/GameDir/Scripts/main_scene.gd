extends Node3D

@onready var hitSound = $ball/hit
var time_passed = 0

func _ready() -> void:
	$"AI".text = "AI: " + str(GlobalVAR.player1)
	$"YOU".text = "You: " + str(GlobalVAR.player0)

	Bridge.advertisement.connect("interstitial_state_changed", Callable(self, "_on_interstitial_state_changed"))
	Bridge.advertisement.set_minimum_delay_between_interstitial(60)

func _on_interstitial_state_changed(state: String) -> void:
	if state == "opened":
		Engine.time_scale = 0.0
		$music.stream_paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif state == "closed" or state == "failed":
		Engine.time_scale = 1.0
		$music.stream_paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _ShowAd():
	Bridge.advertisement.show_interstitial()

@onready var music = $music
func _process(delta: float) -> void:
	if not music.playing:
		music.play()

	# Example: trigger ad every 60s of playtime
	time_passed += delta
	if time_passed >= 60.0:
		_ShowAd()
		time_passed = 0.0

func _on_left_body_entered(body: Node3D) -> void:
	if body.name == "ball":
		GlobalVAR.ballSpeedX *= -1
		hitSound.play()
func _on_right_body_entered(body: Node3D) -> void:
	if body.name == "ball":
		GlobalVAR.ballSpeedX *= -1
		hitSound.play()

func _on_player_1_score_body_entered(body: Node3D) -> void:
	if body.name == "ball":
		GlobalVAR.ballOutside = true
		GlobalVAR.player1 += 1
		$"AI".text = "AI: " + str(GlobalVAR.player1)
		$"YOU".text = "You: " + str(GlobalVAR.player0)
func _on_player_1_score_body_exited(body: Node3D) -> void:
	if body.name == "ball":
		GlobalVAR.ballOutside = false

func _on_player_0_score_body_entered(body: Node3D) -> void:
	if body.name == "ball":
		GlobalVAR.ballOutside = true
		GlobalVAR.player0 += 1
func _on_player_0_score_body_exited(body: Node3D) -> void:
	if body.name == "ball":
		GlobalVAR.ballOutside = false
		$"AI".text = "AI: " + str(GlobalVAR.player1)
		$"YOU".text = "You: " + str(GlobalVAR.player0)

func _on_player_0_area_body_entered(body: Node3D) -> void:
	if body.name == "ball":
		GlobalVAR.ballSpeedZ *= -1
		hitSound.play()
func _on_player_1_area_body_entered(body: Node3D) -> void:
	if body.name == "ball":
		GlobalVAR.ballSpeedZ *= -1
		hitSound.play()
