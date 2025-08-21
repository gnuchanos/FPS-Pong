# main.gd
extends Control

# Oyuncu verileri
var current_level: int = 1
var current_score: int = 0

func _Load():
	if not FileAccess.file_exists('user://GameData.save'):return
	var File = FileAccess.open('user://GameData.save',FileAccess.READ)
	values=JSON.parse_string(File.get_line())
	File.close()

func _on_interstitial_state_changed(args):
	print("Interstitial state: ", args)

	if args == "opened":
		Engine.time_scale = 0.0
	elif args == "closed" or args == "failed":
		Engine.time_scale = 1.0
		save_player_progress()

func _ready():
	if GlobalVAR.Platform=='PlayGama':
		Bridge.advertisement.interstitial_state_changed.connect(_on_interstitial_state_changed)
		Bridge.platform.send_message(Bridge.PlatformMessage.GAME_READY)

		if Bridge.storage.is_available(Bridge.StorageType.PLATFORM_INTERNAL):
			Bridge.storage.get("GameData", Callable(self._on_storage_get_completed), Bridge.StorageType.PLATFORM_INTERNAL)
			_Load()

	print(Bridge.advertisement.get_signal_list())

var keys = ["level", "score"]
var values = [current_level, current_score]

func _Save():
	var File = FileAccess.open('user://GameData.save',FileAccess.WRITE)
	File.store_line(JSON.stringify(values))
	File.close()

func Save():
	if GlobalVAR.Platform=='PlayGama':
		_Save()
		Bridge.storage.set('GameData',JSON.stringify(keys), Callable(self._on_storage_set_completed), Bridge.StorageType.PLATFORM_INTERNAL)

func save_player_progress():
	# Verileri Playgama storage ile kaydet
	if GlobalVAR.Platform=='PlayGama':
		Save()



func _on_storage_set_completed(success: bool) -> void:
	if success:
		print("Oyuncu ilerlemesi başarıyla kaydedildi.")
	else:
		print("Oyuncu ilerlemesi kaydedilemedi.")


func _on_startgame_pressed() -> void:
	get_tree().change_scene_to_file("res://GameDir/Scenes/main_scene.tscn")

func _on_settings_pressed() -> void:
	$UI/settings.show()
