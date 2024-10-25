#AUTOLOADED: Inventory
extends Node
const INVENTORY = preload("res://src/assets/entity/player/resources/player_inventory.tres")
const MORTUM = preload("res://src/assets/entity/elements/resources/mortum.tres")

var talked_with_guide: bool = false
var Unlocked_Mortum: bool = false
func _ready():
	print(MORTUM)

#Recipe functions
func add_recipe(recipe: Recipe_Res):
	if not INVENTORY._elements.has(recipe):
		INVENTORY._recipes.append(recipe)

func remove_recipe(recipe: Recipe_Res):
	if INVENTORY._recipes.has(recipe):
		INVENTORY._recipes.erase(recipe)

func contains_recipe(recipe: Recipe_Res):
	return INVENTORY._recipes.has(recipe)

func get_recipes():
	if INVENTORY._recipes == null:
		push_error("recipe array is empty")
	else: 
		return INVENTORY._recipes

#Element functions
func add_element(element: Element_Res):
	print(element)
	if not INVENTORY._elements.has(element):
		if element == MORTUM: 
			Unlocked_Mortum = true
		INVENTORY._elements.append(element)

func remove_element(element: Element_Res):
	if INVENTORY._elements.has(element):
		INVENTORY._elements.erase(element)

func contains_element(element: Element_Res):
	return INVENTORY._elements.has(element)
