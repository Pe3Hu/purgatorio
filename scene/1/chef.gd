extends MarginContainer


@onready var assistants = $Assistants

var cradle = null


func set_attributes(input_: Dictionary) -> void:
	cradle = input_.cradle
	
	init_assistants()


func init_assistants() -> void:
	for _i in 3:
		var input = {}
		input.chef = self
	
		var assistant = Global.scene.assistant.instantiate()
		assistants.add_child(assistant)
		assistant.set_attributes(input)
