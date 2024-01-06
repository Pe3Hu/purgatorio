extends MarginContainer


@onready var quartet = $Quartet

var grimoire = null


func set_attributes(input_: Dictionary) -> void:
	grimoire = input_.grimoire
	
	set_quartet()


func set_quartet() -> void:
	var input = {}
	input.proprietor = self
	quartet.set_attributes(input)
