extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	#var a = $Panel.get_theme().get_stylebox("panel","")#Panel.styles.panel
	#a.set_bg_color(Color("#bada55"))    # green
	#var stylebox = $Panel.get("theme_override_styles/panel").duplicate()
	#$Panel.set('theme_override_styles/panel', stylebox)
	var panel = Panel.new()
	add_child(panel)
	move_child(panel, 0)
	panel.set("theme_override_styles/panel", Global.theme[parent.word.source])
	var c = Global.theme[parent.word.source]
	#$Panel.set("theme_override_styles/panel", Global.theme[parent.word.source])
	#var a = $Panel.get("theme_override_styles/panel")

	var color = Color() 
	
	match parent.word.source:
		"physical":
			color = Color("white")
		"fire":
			color = Color("red")
	
	$Panel.get("theme_override_styles/panel").set_bg_color(color) 
	print(parent.word.source)
	var d = get_children()
	var b = null
	#set_theme(Global.theme[parent.word.source])

func update_value() -> void:
	$Value.text = str(parent.word.value)
	#update_color()
	#var a = $Panel.get_stylebox("normal").duplicate()
	#theme_override_styles.panel.bg_color = Color("grey")
