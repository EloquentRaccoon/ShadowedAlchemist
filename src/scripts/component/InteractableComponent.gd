extends Area2D
class_name InteractableComponent

var interact: Callable = func():
	pass

var register: Callable = func():
	pass

var player: PlayerManager
var active: bool = true:
	set(value):
		active = value
		player.interaction.unregister_area()

func _on_body_entered(body: PlayerManager):
	player = body
	if active:
		if player.interaction:
			player.interaction.register_area(self)
		else: 
			print("InteractionManager is not set")
	else:
		print("Area is not active")

func _on_body_exited(body: PlayerManager):
	player = body
	player.interaction.unregister_area()
