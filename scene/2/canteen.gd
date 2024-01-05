extends MarginContainer


@onready var kitchens = $Kitchens

var sketch = null


func set_attributes(input_: Dictionary) -> void:
	sketch = input_.sketch
	
	init_kitchens()


func init_kitchens() -> void:
	for _i in 1:
		var input = {}
		input.canteen = self
	
		var kitchen = Global.scene.kitchen.instantiate()
		kitchens.add_child(kitchen)
		kitchen.set_attributes(input)
