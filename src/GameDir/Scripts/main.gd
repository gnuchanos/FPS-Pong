extends Control


func _ready():
	if Engine.has_singleton("Bridge"):
		var bridge = Engine.get_singleton("Bridge")
		bridge.game_ready()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://GameDir/Scenes/main_scene.tscn")

	$text/AnimationPlayer.play("anim")
