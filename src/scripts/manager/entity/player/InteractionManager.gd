extends Node2D
class_name InteractionManager

@onready var interact_icon = $InteractIcon

var active_area: InteractableComponent
var can_interact: bool = true

func register_area(area: InteractableComponent):
	active_area = area
	active_area.register.call()
	
func unregister_area():
	active_area = null
		
func _process(_delta):
	if active_area != null && can_interact:
		interact_icon.global_position = self.global_position
		interact_icon.show()
	else:
		interact_icon.hide()
		
func _input(event):
	if event.is_action_pressed("interact") && can_interact && active_area != null :
		if active_area is InteractableComponent:
			can_interact = false;
			interact_icon.hide()
			await active_area.interact.call()
			can_interact = true
