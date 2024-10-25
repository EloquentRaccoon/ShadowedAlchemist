extends Node2D

signal switch_scene

@export var scene_destination: Scene_Manager.SceneNames
@onready var interactionComponent: InteractableComponent = $InteractableComponent

func _ready():
	interactionComponent.interact = Callable(self, "_on_interact")

func _on_interact():
	switch_scene.emit(scene_destination)
