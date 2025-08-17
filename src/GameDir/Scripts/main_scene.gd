extends Node3D

@onready var hitSound = $ball/hit

func _ready() -> void:
	$"AI".text = "AI: " + str(GlobalVAR.player1)
	$"YOU".text = "You: " + str(GlobalVAR.player0)

@onready var music = $music
func _process(delta: float) -> void:
	if not music.playing:
		music.play()

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
