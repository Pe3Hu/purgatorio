extends MarginContainer


@onready var bg = $BG

var cauldron = null
var grid = null


func set_attributes(input_: Dictionary) -> void:
	cauldron = input_.cauldron
	grid = input_.grid
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = cauldron.dimensions.section
	var style = StyleBoxFlat.new()
	style.bg_color = Color.SLATE_GRAY
	bg.set("theme_override_styles/panel", style)


func set_color(color_: String) -> void:
	var style = bg.get("theme_override_styles/panel")
	style.bg_color = Global.color.color[color_]
