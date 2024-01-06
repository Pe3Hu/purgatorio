extends MarginContainer


@onready var verse = $Verse
@onready var interlude = $Interlude
@onready var apotheosis = $Apotheosis
@onready var mana = $Mana

var proprietor = null


func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	
	init_basic_setting()


func init_basic_setting() -> void:
	for key in Global.arr.quartet:
		var input = {}
		input = {}
		input.type = "number"
		input.subtype = 0#input_[key]
		
		var icon = get(key)
		icon.set_attributes(input)
		icon.custom_minimum_size = Vector2(Global.vec.size.sixteen)
	
	custom_minimum_size = Vector2(Global.vec.size.quartet)
	#custom_minimum_size = title.custom_minimum_size + stack.custom_minimum_size * 0.75
