extends Node

signal warp

@export var scene_destination: Scene_Manager.SceneNames
@onready var interactionComponent: InteractableComponent = $InteractableComponent

func _ready():
	interactionComponent.interact = Callable(self, "_on_teleport")

func _on_teleport():
	if scene_destination:
		warp.emit(scene_destination)
	else:
		print("scene_destination is not yet been set to destination")
