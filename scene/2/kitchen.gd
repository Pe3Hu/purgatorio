extends MarginContainer


@onready var decks = $Decks
@onready var left = $Decks/Left
@onready var right = $Decks/Right

var canteen = null


func set_attributes(input_: Dictionary) -> void:
	canteen = input_.canteen
	
	init_desks()


func init_desks() -> void:
	for side in Global.arr.side:
		var input = {}
		input.kitchen = self
		input.side = side
	
		var desk = get(side)
		desk.set_attributes(input)
