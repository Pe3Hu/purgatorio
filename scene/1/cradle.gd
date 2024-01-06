extends MarginContainer


@onready var chefs = $Chefs

var sketch = null


func set_attributes(input_: Dictionary) -> void:
	sketch = input_.sketch
	
	init_chefs()


func init_chefs() -> void:
	for _i in 1:
		var input = {}
		input.cradle = self
	
		var chef = Global.scene.chef.instantiate()
		chefs.add_child(chef)
		chef.set_attributes(input)
