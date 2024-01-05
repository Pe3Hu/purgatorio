extends MarginContainer


@onready var sections = $Sections

var desk = null
var dimensions = null


func set_attributes(input_: Dictionary) -> void:
	desk = input_.desk
	dimensions = input_.dimensions
	
	init_sections()
	#Engine.time_scale = 3


func init_sections() -> void:
	sections.columns = dimensions.grid.x
	
	for _i in dimensions.grid.y:
		for _j in dimensions.grid.x:
			var input = {}
			input.cauldron = self
			input.grid = Vector2(_j, _i)
			
			var section = Global.scene.section.instantiate()
			sections.add_child(section)
			section.set_attributes(input)
