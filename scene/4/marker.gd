extends MarginContainer


@onready var assistant = $HBox/Assistant
@onready var order = $HBox/Order

var proprietor = null


func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	
	init_basic_setting()


func init_basic_setting() -> void:
	var keys = ["assistant", "order"]
	
	for key in keys:
		var input = {}
		input = {}
		input.type = "number"
		input.subtype = 0#input_[key]
		
		var icon = get(key)
		icon.set_attributes(input)
		icon.custom_minimum_size = Vector2(Global.vec.size.sixteen)
