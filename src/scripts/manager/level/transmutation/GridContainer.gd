extends GridContainer

var elements_group:ResourceGroup = load("res://src/assets/entity/elements/all_elements.tres") 
var elements: Array[Element_Res] = []

func _ready():
	elements_group.load_all_into(elements)
	reload()

func reload():
	for n in get_children():
		remove_child(n)
		n.queue_free()

	for element: Element_Res in elements:
		if Inventory_Manager.contains_element(element):
			var button = Button.new()
			button.name = element.name
			button.icon = element.image
			button.button_down.connect(get_parent().get_parent()._on_button_down.bind(element))
			add_child(button)
	
	columns = roundi(float(get_child_count())/ 2)
