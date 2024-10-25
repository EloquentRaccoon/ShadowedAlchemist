class_name InventoryDialog
extends PanelContainer

@export var item_scene: PackedScene
@onready var inventory_space: GridContainer = %InventorySpace

func open():
	show()
	
	for child in inventory_space.get_children():
		child.queue_free()
	#
	for recipe:Recipe_Res in Inventory_Manager.get_recipes():
		var slot = item_scene.instantiate()
		inventory_space.add_child(slot)
		if slot.has_method("show_recipe"):
			slot.show_recipe(recipe)

func close():
	hide()
