class_name Recipe
extends Node2D

@export var recipe:Recipe_Res

@onready var interactionComponent: InteractableComponent = $InteractableComponent
@onready var label = $RichTextLabel
@onready var element = $Element
@onready var icon = %Icon

func _ready():
	if Inventory_Manager.get_recipes().has(recipe):
		self.queue_free()
	else:
		show()
		icon.texture = recipe.image
		interactionComponent.interact = Callable(self, "_on_recipe_picked_up",)
		interactionComponent.register = Callable(self, "_on_recipe_found")
	
func _on_recipe_picked_up():
	if recipe != null:
		Inventory_Manager.add_recipe(recipe)
	else:
		print("recipe resource is not yet set")
		push_error("recipe resource is not yet set")
	self.queue_free()
	
func _on_recipe_found():
	label.text = str(recipe.elements[0].name) + " + " + str(recipe.elements[1].name)
	label.fit_content = true
	label.add_theme_font_size_override("normal_font_size", 28)
	
	element.text = self.name
	element.add_theme_font_size_override("normal_font_size", 28)
	element.add_theme_color_override("default_color", Color.CORNSILK)
