class_name ItemSlot
extends PanelContainer

@onready var item_icon: TextureRect = %ItemIcon
@onready var item_name = %ItemName
@onready var hover_text = %HoverText

var style:StyleBoxFlat = StyleBoxFlat.new()

func _ready():
	style.bg_color = Color(0.197, 0.2, 0.183)
	self.add_theme_stylebox_override("panel",  style)


func show_recipe(recipe: Recipe_Res):
	item_icon.texture = recipe.image
	item_name.text = recipe.recipe_name
	var hoverText: String
	var loopcount: int = 0
	for element in recipe.elements:
		if loopcount > 0: 
			hoverText += " + "
		loopcount+= 1
		hoverText += element.name
	hover_text.text = hoverText

func _on_mouse_entered():
	style.bg_color = Color(0.325, 0.329, 0.305)
	hover_text.show()


func _on_mouse_exited():
	style.bg_color = Color(0.197, 0.2, 0.183)
	hover_text.hide()
