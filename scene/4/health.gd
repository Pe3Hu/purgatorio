extends MarginContainer


@onready var marker = $HBox/Marker
@onready var indicator = $HBox/Indicatorx

var waiter = null


func set_attributes(input_: Dictionary) -> void:
	waiter = input_.waiter
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.proprietor = waiter
	marker.set_attributes(input)
	
	input.proprietor = self
	input.type = "health"
	indicator.set_attributes(input)
