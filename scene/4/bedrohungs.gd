extends MarginContainer


var condition = null
var stapel = null


func set_vars(condition_, stapel_) -> void:
	condition = condition_
	stapel = stapel_
	add_child(stapel.scene.myself)
	set_corners()


func set_corners() -> void:
	var order = "even"
	var unorder = []
	var corners = null
	
	match condition.scope:
		"diener":
			corners = 3
		"kessel":
			corners = 4
	
	var r = Global.num.wertmarke.size.r[corners]
	var R = Global.num.wertmarke.size.R[corners]
	var radiuses = [r,R,r]
	var orders = [Global.dict.order.pair[order],order,Global.dict.order.pair[order]]
	var shift = null
	
	match order:
		"even":
			shift = -1
		"odd":
			shift = 1
	
	
	var indexs = Global.dict.bedrohung.corner.description[condition.scope][condition.criterion][condition.extreme]
	
	for corner in indexs:
		var polygon = Polygon2D.new()
		var vertexs = []
		var vertex = Global.dict.bedrohung.corner.vector[corners][orders[0]][corner]*radiuses[0]
		vertexs.append(vertex)
		vertex = Global.dict.bedrohung.corner.vector[corners][orders[1]][corner]*radiuses[1]
		vertexs.append(vertex)
		var previous_corner = (corner+corners+shift)%corners
		vertex = Global.dict.bedrohung.corner.vector[corners][orders[2]][previous_corner]*radiuses[2]
		vertexs.append(vertex)
		polygon.set_polygon(vertexs)
		var color = Color("dark_gray")
		polygon.set_color(color)
		$corners.add_child(polygon)
