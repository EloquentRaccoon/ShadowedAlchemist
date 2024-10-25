extends CanvasLayer

@onready var inventory_dialog = %InventoryDialog

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		if inventory_dialog.visible:
			inventory_dialog.close()
		else:
			inventory_dialog.open()
