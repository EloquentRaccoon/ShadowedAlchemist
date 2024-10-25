extends Node2D

@export var exit_scene: Scene_Manager.SceneNames

@onready var output = get_node("Output")
@onready var sprite1 = get_node("Element1/Sprite2D")
@onready var sprite2 = get_node("Element2/Sprite2D")
@onready var elementsDisplay = get_node("ScrollContainer/GridContainer")


var recipes_group:ResourceGroup = preload("res://src/assets/entity/recipe/all_recipes.tres") 
var recipes: Array[Recipe_Res] = []

var selectedElement
var element1: Element_Res 
var element2: Element_Res

func _ready():
	recipes_group.load_all_into(recipes)

func reset_screen_inputs():
	output.texture = null
	sprite1.texture = null
	sprite2.texture = null
	element1 = null
	element2 = null
	elementsDisplay.reload()

func checkRecipes():
	if element1 == null or element2 == null:
		pass

	for recipe: Recipe_Res in recipes:
		if Inventory_Manager.contains_recipe(recipe):
			if recipe.elements.has(element1) && recipe.elements.has(element2):
				if recipe.result_element:
					output.texture = recipe.result_element.image
				else:
					print("result_element is not set")
				Inventory_Manager.add_element(recipe.result_element)
				await get_tree().create_timer(1).timeout #TODO: Play animation
				reset_screen_inputs()
	if Inventory_Manager.Unlocked_Mortum:
		Scene_Manager.switch_to_scene(Scene_Manager.SceneNames.ending)

func _on_button_down(extra_arg_0: Element_Res):
	selectedElement = extra_arg_0
	Input.set_custom_mouse_cursor(selectedElement.image)

func _on_element_1_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_mouse"):
		if selectedElement != null:
			sprite1.texture = selectedElement.image
			element1 = selectedElement
			selectedElement = null
			Input.set_custom_mouse_cursor(null)
			checkRecipes()
		else:
			sprite1.texture = null
			element1 = null

func _on_element_2_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_mouse"):
		if selectedElement != null:
			sprite2.texture = selectedElement.image
			element2 = selectedElement
			selectedElement = null
			Input.set_custom_mouse_cursor(null)
			checkRecipes()
		else:
			sprite2.texture = null
			element2 = null
			
func _on_exit_pressed():
	Input.set_custom_mouse_cursor(null)
	Scene_Manager.switch_to_scene(exit_scene)
