extends MarginContainer


@onready var cauldrons = $HBox/Cauldrons
@onready var grimoire = $HBox/Grimoire

var kitchen = null


func set_attributes(input_: Dictionary) -> void:
	kitchen = input_.kitchen
	
	init_cauldrons()
	init_grimoire()


func init_cauldrons() -> void:
	var n = 3
	
	for _i in n:
		var input = {}
		input.desk = self
		input.dimensions = {}
		input.dimensions.grid = Vector2.ONE * (_i + 1)
		input.dimensions.section = Global.vec.size.section / input.dimensions.grid * n
	
		var cauldron = Global.scene.cauldron.instantiate()
		cauldrons.add_child(cauldron)
		cauldron.set_attributes(input)


func init_grimoire() -> void:
	var input = {}
	input.desk = self
	grimoire.set_attributes(input)


