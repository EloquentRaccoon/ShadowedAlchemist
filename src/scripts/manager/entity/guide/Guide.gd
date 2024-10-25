extends Node2D

@onready var interactionComponent: InteractableComponent = $InteractableComponent
@onready var background = $Panel
@onready var text = $Panel/RichTextLabel
@onready var animation = $Guide

var waiting = false
var dialog: Array = [
	"Oh you seem new here! This is the shadow realm!",
	"Seems like you got your consciousness stuck here in by using forbidden alchemy...",
	"If you want to try to return to your former body",
	"You should create the element Mortum!",
	"You can find more forbidden alchemy here to achieve it, but no one made it so far...",
	"To perform the alchemy go back use the huge pillar",
	"You can open your inventory with [TAB] and sprint with [SHIFT]",
	"Good luck!"
]
var dialog_counter  = 0

func _ready():
	if Inventory_Manager.talked_with_guide: 
		self.queue_free()
	else:
		interactionComponent.interact = Callable(self, "_on_interact")
		animation.play()
		background.hide()
		text.hide()

func _on_interact():
	if dialog.size() > dialog_counter:
		text.text = dialog[dialog_counter]
		dialog_counter += 1
		background.show()
		text.show()
	else:
		Inventory_Manager.talked_with_guide = true
		interactionComponent.active = false
		text.hide()
		background.hide()
