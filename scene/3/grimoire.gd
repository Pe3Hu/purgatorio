extends MarginContainer


@onready var spells = $Spells

var desk = null


func set_attributes(input_: Dictionary) -> void:
	desk = input_.desk
	
	init_spells()


func init_spells() -> void:
	for _i in 1:
		var input = {}
		input.grimoire = self
	
		var spell = Global.scene.spell.instantiate()
		spells.add_child(spell)
		spell.set_attributes(input)
