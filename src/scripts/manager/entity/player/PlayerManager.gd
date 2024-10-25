class_name PlayerManager
extends CharacterBody2D

@export var movement: PlayerMovement
@export var animation: AnimatedSprite2D
@export var interaction: InteractionManager
var destination

func _process(delta):
	if movement.Can_Move:
		movement.Move_Character(delta)
	if animation:
		animation.handle_animation(is_on_floor())

func _on_animation_component_animation_finished():
	if animation.animation == "warp": 
		Scene_Manager.switch_to_scene(destination)

func _on_switch_scene(target: Scene_Manager.SceneNames):
	self.destination = target
	if destination == Scene_Manager.SceneNames.overworld or destination == Scene_Manager.SceneNames.shadowrealm:
		animation.warp()
		movement.Can_Move = false
	else:
		Scene_Manager.switch_to_scene(destination)	
