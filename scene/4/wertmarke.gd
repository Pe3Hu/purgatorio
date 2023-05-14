extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	add_panel()
	update_value()
	#add_circular_polygon()


func add_panel() -> void:
	var panel = Panel.new()
	add_child(panel)
	move_child(panel, 0)
	panel.set("theme_override_styles/panel", Global.theme[parent.word.source])


func add_circular_polygon() -> void:
	var polygon = Polygon2D.new()
	var vertexs = []
	var center = custom_minimum_size/2
	var a = center.x
	var n = 360
	var color = Color() 

	match parent.word.source:
		"physical":
			color = Color("white")
		"fire":
			color = Color("red")
	
	for _i in n:
		var angle = 2*PI*_i/n
		var vertex = Vector2(0,1).rotated(angle) * a + center
		vertexs.append(vertex)

	polygon.set_color(color) 
	polygon.set_polygon(vertexs)
	
	add_child(polygon)
	move_child(polygon, 0)


func update_value() -> void:
	$Value.text = str(parent.num.value)
