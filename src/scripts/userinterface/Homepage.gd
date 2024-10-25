extends Node

@export var playScene: Scene_Manager.SceneNames
@export var settingsScene: Scene_Manager.SceneNames

func _ready():
	pass

func _on_play_pressed():
	Scene_Manager.switch_to_scene(playScene)


func _on_settings_pressed():
	print("not implemented yet")
	#Scene_Manager.switch_to_scene(settingsScene)


func _on_quit_pressed():
	get_tree().quit()
