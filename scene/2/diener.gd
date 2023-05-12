extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_


func update_color() -> void:
	if parent.obj.wirt.obj.kessel != null:
		var max_h = 360.0
		var h = 0.75
		var s = 1
		var v = 1
		
		match parent.obj.wirt.obj.kessel.word.side:
			"left":
				h = 210.0/max_h
			"right":
				h = 330.0/max_h
		
		s = float(parent.obj.schaufensterpuppe.num.indicator.health.current)/parent.obj.schaufensterpuppe.num.indicator.health.max
		
		$BG.color = Color.from_hsv(h,s,v)


func update_health() -> void:
	$Health.text = str(parent.obj.schaufensterpuppe.num.indicator.health.current)
	update_color()


func resize_by_wirt_archetype() -> void:
	custom_minimum_size = Global.vec.size.kessel/parent.obj.wirt.obj.kessel.scene.myself.columns
