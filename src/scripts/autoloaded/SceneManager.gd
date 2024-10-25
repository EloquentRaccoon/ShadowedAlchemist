# AUTOLOADED: Scene_Manager 
extends Node

enum SceneNames {
	none = 0,
	overworld = 1,
	shadowrealm = 2,
	transmutation = 3,
	homepage = 4,
	ending = 5,
}

var scenes = {
	SceneNames.overworld : preload("res://src/scenes/level/overworld/Overworld.tscn"),
	SceneNames.shadowrealm: preload("res://src/scenes/level/shadowrealm/ShadowRealm.tscn"),
	SceneNames.transmutation: preload("res://src/scenes/level/transmutation/Transmutation.tscn"),
	SceneNames.homepage: preload("res://src/scenes/userinterface/main/Homepage.tscn"),
	SceneNames.ending: preload("res://src/scenes/userinterface/ending/Ending.tscn")
}

func switch_to_scene(next_scene: SceneNames) -> void:
	if next_scene == 0:
		print("Scene destination not implemented yet")
	else:
		get_tree().change_scene_to_packed(scenes[next_scene])
